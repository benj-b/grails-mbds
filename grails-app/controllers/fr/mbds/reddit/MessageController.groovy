package fr.mbds.reddit

import grails.plugin.springsecurity.SpringSecurityService
import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

@Secured(['ROLE_ADMIN', 'ROLE_USER'])
class MessageController {

    MessageService messageService
    SpringSecurityService springSecurityService
    UserService userService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond messageService.list(params), model:[messageCount: messageService.count()]
    }

    def show(Long id) {
        respond messageService.get(id)
    }

    def create() {
        respond new Message(params)
    }

    def save(Message messageInput) {
        if (messageInput == null) {
            notFound()
            return
        }

        try {
            messageInput.author = userService.get(springSecurityService.principal?.id)
            messageService.save(messageInput)
        } catch (ValidationException e) {
            respond messageInput.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'message.label', default: 'Message'), messageInput.id])
                redirect messageInput
            }
            '*' { respond messageInput, [status: CREATED] }
        }
    }

    def edit(Long id) {
        def loggedInUserId = springSecurityService.principal?.id as Long
        def isAuthor = (loggedInUserId == messageService.get(id).author.id)
        if (springSecurityService.isLoggedIn() && (springSecurityService.principal.authorities.find { it.authority == 'ROLE_ADMIN' } || isAuthor)) {
            respond messageService.get(id)
        } else {
            response.sendError(403, 'Forbidden')
        }
    }

    def update(Message message) {
        if (message == null) {
            notFound()
            return
        }

        def loggedInUserId = springSecurityService.principal?.id as Long
        def isAuthor = (loggedInUserId == messageService.get(message.id).author.id)
        if (springSecurityService.isLoggedIn() && (springSecurityService.principal.authorities.find { it.authority == 'ROLE_ADMIN' } || isAuthor)) {
            try {
                messageService.save(message)
            } catch (ValidationException e) {
                respond message.errors, view: 'edit'
                return
            }

            request.withFormat {
                form multipartForm {
                    flash.message = message(code: 'default.updated.message', args: [message(code: 'message.label', default: 'Message'), message.id])
                    redirect message
                }
                '*' { respond message, [status: OK] }
            }
        } else {
            response.sendError(403, 'Forbidden')
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        def loggedInUserId = springSecurityService.principal?.id as Long
        def isAuthor = loggedInUserId == messageService.get(id).author.id

        if (springSecurityService.isLoggedIn() && (springSecurityService.principal.authorities.find { it.authority == 'ROLE_ADMIN' } || isAuthor)) {
            messageService.delete(id)
            request.withFormat {
                form multipartForm {
                    flash.message = message(code: 'default.deleted.message', args: [message(code: 'message.label', default: 'Message'), id])
                    redirect action: "index", method: "GET"
                }
                '*' { render status: NO_CONTENT }
            }
        } else {
            response.sendError(403, 'Forbidden')
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'message.label', default: 'Message'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
