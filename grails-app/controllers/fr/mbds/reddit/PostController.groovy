package fr.mbds.reddit

import grails.plugin.springsecurity.SpringSecurityService
import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

@Secured(['ROLE_ADMIN', 'ROLE_USER'])
class PostController {

    PostService postService
    SpringSecurityService springSecurityService
    UserService userService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond postService.list(params), model:[postCount: postService.count()]
    }

    def show(Long id) {
        respond postService.get(id)
    }

    def create() {
        respond new Post(params)
    }

    def save(Post post) {
        if (post == null) {
            notFound()
            return
        }

        try {
            post.author = userService.get(springSecurityService.principal.id)
            postService.save(post)
        } catch (ValidationException e) {
            respond post.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'post.label', default: 'Post'), post.id])
                redirect post
            }
            '*' { respond post, [status: CREATED] }
        }
    }

    def edit(Long id) {
        def loggedInUserId = springSecurityService.principal?.id as Long
        def isAuthor = (loggedInUserId == postService.get(id).author.id)
        if (springSecurityService.isLoggedIn() && (springSecurityService.principal.authorities.find { it.authority == 'ROLE_ADMIN' } || isAuthor)) {
            respond postService.get(id)
        } else {
            response.sendError(403, 'Forbidden')
        }
    }

    def update(Post post) {
        if (post == null) {
            notFound()
            return
        }

        def loggedInUserId = springSecurityService.principal?.id as Long
        def isAuthor = (loggedInUserId == postService.get(post.id).author.id)
        if (springSecurityService.isLoggedIn() && (springSecurityService.principal.authorities.find { it.authority == 'ROLE_ADMIN' } || isAuthor)) {
            try {
                postService.save(post)
            } catch (ValidationException e) {
                respond post.errors, view:'edit'
                return
            }

            request.withFormat {
                form multipartForm {
                    flash.message = message(code: 'default.updated.message', args: [message(code: 'post.label', default: 'Post'), post.id])
                    redirect post
                }
                '*'{ respond post, [status: OK] }
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
        def isAuthor = loggedInUserId == postService.get(id).author.id

        if (springSecurityService.isLoggedIn() && (springSecurityService.principal.authorities.find { it.authority == 'ROLE_ADMIN' } || isAuthor)) {
            postService.delete(id)

            request.withFormat {
                form multipartForm {
                    flash.message = message(code: 'default.deleted.message', args: [message(code: 'post.label', default: 'Post'), id])
                    redirect action:"index", method:"GET"
                }
                '*'{ render status: NO_CONTENT }
            }
        } else {
            response.sendError(403, 'Forbidden')
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'post.label', default: 'Post'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
