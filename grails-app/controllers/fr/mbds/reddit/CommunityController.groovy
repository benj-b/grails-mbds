package fr.mbds.reddit

import grails.plugin.springsecurity.SpringSecurityService
import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

@Secured(['ROLE_ADMIN', 'ROLE_USER'])
class CommunityController {

    CommunityService communityService
    SpringSecurityService springSecurityService
    UserService userService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond communityService.list(params), model:[communityCount: communityService.count()]
    }

    def show(Long id) {
        respond communityService.get(id)
    }

    def create() {
        respond new Community(params)
    }

    def save(Community community) {
        if (community == null) {
            notFound()
            return
        }
        try {
            // Set Author to current logged in user
            community.author = userService.get(springSecurityService.principal.id)
            communityService.save(community)
        } catch (ValidationException e) {
            respond community.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'community.label', default: 'Community'), community.id])
                redirect community
            }
            '*' { respond community, [status: CREATED] }
        }
    }

    def edit(Long id) {
        def loggedInUserId = springSecurityService.principal?.id as Long
        def isAuthor = (loggedInUserId == communityService.get(id).author.id)
        if (springSecurityService.isLoggedIn() && (springSecurityService.principal.authorities.find { it.authority == 'ROLE_ADMIN' } || isAuthor)) {
            respond communityService.get(id)
        } else {
            response.sendError(403, 'Forbidden')
        }
    }

    def update(Community community) {
        if (community == null) {
            notFound()
            return
        }

        def loggedInUserId = springSecurityService.principal?.id as Long
        def isAuthor = (loggedInUserId == communityService.get(community.id).author.id)
        if (springSecurityService.isLoggedIn() && (springSecurityService.principal.authorities.find { it.authority == 'ROLE_ADMIN' } || isAuthor)) {
            try {
                def selectedUserIds = params.list('members')
                print(selectedUserIds)
                if (selectedUserIds) {
                    def selectedMembers = selectedUserIds.collect { userService.get(it) }
                    selectedMembers.collect { it.addToCommunities(community) }
                    community.members = selectedMembers
                }
                communityService.save(community)
            }
            catch (ValidationException e) {
                respond community.errors, view: 'edit'
                return
            }
            request.withFormat {
                form multipartForm {
                    flash.message = message(code: 'default.updated.message', args: [message(code: 'community.label', default: 'Community'), community.id])
                    redirect community
                }
                '*' { respond community, [status: OK] }
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
        def isAuthor = loggedInUserId == communityService.get(id).author.id

        if (springSecurityService.isLoggedIn() && (springSecurityService.principal.authorities.find { it.authority == 'ROLE_ADMIN' } || isAuthor)) {
            User.getAll().findAll { it.communities.removeAll {it.id == id} }
            communityService.delete(id)

            request.withFormat {
                form multipartForm {
                    flash.message = message(code: 'default.deleted.message', args: [message(code: 'community.label', default: 'Community'), id])
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
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'community.label', default: 'Community'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
