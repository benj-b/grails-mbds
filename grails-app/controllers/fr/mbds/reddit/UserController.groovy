package fr.mbds.reddit

import grails.validation.ValidationException

import static org.springframework.http.HttpStatus.*
import grails.plugin.springsecurity.annotation.Secured
import grails.plugin.springsecurity.SpringSecurityService


@Secured(['ROLE_ADMIN', 'ROLE_USER'])
class UserController {

    UserService userService
    SpringSecurityService springSecurityService
    CommunityService communityService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond userService.list(params), model:[userCount: userService.count()]
    }


    def show(Long id) {
        def loggedInUserId = springSecurityService.principal?.id as Long
        if (springSecurityService.isLoggedIn() && (springSecurityService.principal.authorities.find { it.authority == 'ROLE_ADMIN' } || loggedInUserId == id)) {
            println(springSecurityService.principal.authorities)
            respond userService.get(id)
        } else {
            response.sendError(403, "Forbidden")
        }
    }

    @Secured('ROLE_ADMIN')
    def create() {
        def roleList = Role.list()
        respond new User(params), model: [roleList: roleList]
    }

    @Secured('ROLE_ADMIN')
    def save(User user) {
        if (user == null) {
            notFound()
            return
        }

        try {
            def role = Role.get(params.role)
            userService.save(user)
            UserRole.create(user, role, true)
        } catch (ValidationException e) {
            respond user.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'user.label', default: 'User'), user.id])
                redirect user
            }
            '*' { respond user, [status: CREATED] }
        }
    }

    def edit(Long id) {
        def loggedInUserId = springSecurityService.principal?.id as Long
        def user = userService.get(id)
        if (springSecurityService.isLoggedIn() && (springSecurityService.principal.authorities.find { it.authority == 'ROLE_ADMIN' } || loggedInUserId == id)) {
            respond user
        } else {
            response.sendError(403, "Forbidden")
        }
    }

    def update(User user) {
        if (user == null) {
            notFound()
            return
        }

        def loggedInUserId = springSecurityService.principal?.id as Long
        if (springSecurityService.isLoggedIn() && (springSecurityService.principal.authorities.find { it.authority == 'ROLE_ADMIN' } || loggedInUserId == user.id)) {
            try {
                userService.save(user)
            } catch (ValidationException e) {
                respond user.errors, view:'edit'
                return
            }

            request.withFormat {
                form multipartForm {
                    flash.message = message(code: 'default.updated.message', args: [message(code: 'user.label', default: 'User'), user.id])
                    redirect user
                }
                '*'{ respond user, [status: OK] }
            }

        } else {
            response.sendError(403, "Forbidden")
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        def loggedInUserId = springSecurityService.principal?.id as Long
        if (springSecurityService.isLoggedIn() && (springSecurityService.principal.authorities.find { it.authority == 'ROLE_ADMIN' } || loggedInUserId == id)) {
            def user = userService.get(id)
            if (!user) {
                notFound()
                return
            }

            // Remove the user from communities
            user.communities.each { community ->
                user.removeFromCommunities(community)
                user.save(flush: true)
                community.removeFromMembers(user)
                community.save(flush: true)
            }

            def authorCommunities = Community.getAll().findAll {
                it.author.id == user.id
            }

            Community.deleteAll(authorCommunities)

            userService.delete(id)

            request.withFormat {
                form multipartForm {
                    flash.message = message(code: 'default.deleted.message', args: [message(code: 'user.label', default: 'User'), id])
                    redirect action: "index", method: "GET"
                }
                '*' { render status: NO_CONTENT }
            }
        } else {
            response.sendError(403, "Forbidden")
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
