package fr.mbds.reddit

import grails.converters.JSON
import grails.converters.XML
import grails.gorm.transactions.Transactional
import grails.plugin.springsecurity.annotation.Secured

@Secured('ROLE_ADMIN')
class ApiController {

    def userService
    def communityService
    def postService
    def messageService

    @Transactional
    void deleteUser(String id) {
        def userInstance = userService.get(id)
        def listOfCommunities = Community.findAllByMembers(userInstance)
        listOfCommunities*.delete()
        // userInstance.delete(flush: true)
    }

    /**
     * Ressource SINGLETON USER
     * Répondra à /api/user sur tous les verbes utiles
     * Methodes : GET / PUT / PATCH / DELETE
     */
    def user() {
        switch (request.getMethod()) {
            case "GET":
                if (!params.id)
                    return response.status = 400
                def userInstance = userService.get(params.id)
                if (!userInstance)
                    return response.status = 404
                renderThis(userInstance, request.getHeader("Accept"))
                break

            case "PUT":
                def userId = params.id
                def userInstance = userService.get(userId)
                if (!userInstance) {
                    render(status: 404, text: "L'utilisateur n'a pas été trouvé")
                    return
                }

                def requestData = request.JSON

                // On remet à zéro seulement les champs non obligatoires
                userInstance.properties.each { propertyName, _ ->
                    // Liste des champs non obligatoires
                    def nonMandatoryFields = ['bio', 'thumbnail', 'communities']

                    if (nonMandatoryFields.contains(propertyName) || params.containsKey(propertyName)) {
                        userInstance[propertyName] = null
                    }
                }

                // On met à jour avec les nouvelles données
                requestData.each { key, value ->
                    userInstance[key] = value
                }

                userInstance["lastUpdated"] = new Date()

                userInstance.save()
                renderThis(userInstance, request.getHeader("Accept"))
                break

            case "PATCH":
                if (!request.getHeader("Content-Type").contains("json"))
                    render(status: 400, text: "Le body doit être formaté en JSON")
                def userId = params.id
                def userInstance = userService.get(userId)
                if (!userInstance) {
                    return response.status = 404
                    render(status: 404, text: "L'utilisateur n'a pas été trouvé")
                }
                def requestData = request.JSON

                // On modifie les données
                requestData.each { key, value ->
                    userInstance[key] = value
                }

                userInstance.save()

                renderThis(userInstance, request.getHeader("Accept"))
                break
            case "DELETE":
                def userId = params.id
                def userInstance = userService.get(userId)
                if (!userInstance) {
                    render(status: 404, text: "L'utilisateur n'a pas été trouvé")
                    return
                }
                println("id : " + userId)
                println("userInstance : " + userInstance)

                deleteUserClean(userInstance)
                render(status: 204, text: "L'utilisateur a bien été supprimé")
                break
            default:
                return response.status = 405
                break
        }
        return response.status = 406
    }

    /**
     * Ressource Collection USER
     * Gestion de GET / POST
     */
    def users() {
        switch (request.getMethod()) {
            case "POST":
                if (!request.getHeader("Content-Type").contains("json"))
                    render(status: 400, text: "Le body doit être formaté en JSON")
                def userInstance = new User(request.getJSON())
                if (userInstance.validate()) {
                    userService.save(userInstance)
                    return response.status = 201
                }
                render(status: 400, text: "Une erreur est survenue pendant la sauvegarde de l'utilisateur")
                break
            case "GET":
                def users = userService.list()
                renderThis(users, request.getHeader("Accept"))
                return response.status = 200
                break
            default:
                return response.status = 405
                break
        }
        return response.status = 406

    }

    def community() {
        switch (request.getMethod()) {
            case "GET":
                if (!params.id)
                    return response.status = 400
                def communityInstance = communityService.get(params.id)
                if (!communityInstance)
                    return response.status = 404
                renderThis(communityInstance, request.getHeader("Accept"))
                break
            case "PUT":
                def communityId = params.id
                def communityInstance = communityService.get(communityId)
                if (!communityInstance) {
                    render(status: 404, text: "La communauté n'a pas été trouvée")
                    return
                }

                def requestData = request.JSON

                // On remet à zéro seulement les champs non obligatoires
                communityInstance.properties.each { propertyName, _ ->
                    // Liste des champs non obligatoires
                    def nonMandatoryFields = ["description"]

                    if (nonMandatoryFields.contains(propertyName) || params.containsKey(propertyName)) {
                        communityInstance[propertyName] = null
                    }
                }

                // On met à jour avec les nouvelles données
                requestData.each { key, value ->
                    communityInstance[key] = value
                }

                communityInstance["lastUpdated"] = new Date()

                communityInstance.save()
                renderThis(communityInstance, request.getHeader("Accept"))
                break
            case "PATCH":
                if (!request.getHeader("Content-Type").contains("json"))
                    render(status: 400, text: "Le body doit être formaté en JSON")
                def communityId = params.id
                def communityInstance = communityService.get(communityId)
                if (!communityInstance) {
                    return response.status = 404
                    render(status: 404, text: "La communauté n'a pas été trouvée")
                }
                def requestData = request.JSON

                // On modifie les données
                requestData.each { key, value ->
                    communityInstance[key] = value
                }

                communityInstance.save()

                renderThis(communityInstance, request.getHeader("Accept"))
                break
            case "DELETE":
                def communityId = params.id
                def communityInstance = communityService.get(communityId)

                if (!communityInstance) {
                    render(status: 404, text: "La communauté n'a pas été trouvée")
                    return
                } else {
                    deleteCommunityClean(communityInstance)
                    render(status: 204, text: "La communauté a bien été supprimée")
                }
                break

            default:
                return response.status = 405
                break
        }

        return response.status = 406
    }

    def communities() {
        switch (request.getMethod()) {
            case "GET":
                def communities = communityService.list()
                renderThis(communities, request.getHeader("Accept"))
                return response.status = 200
                break
            case "POST":
                if (!request.getHeader("Content-Type").contains("json"))
                    render(status: 400, text: "Le body doit être formaté en JSON")
                def communityInstance = new Community(request.getJSON())
                if (communityInstance.validate()) {
                    userService.save(communityInstance)
                    return response.status = 201
                }
                render(status: 400, text: "Une erreur est survenue pendant la sauvegarde de la communauté")
                break
            default:
                return response.status = 405
                break
        }
        return response.status = 406
    }

    def post() {
        switch (request.getMethod()) {
            case "GET":
                if (!params.id)
                    return response.status = 400
                def postInstance = postService.get(params.id)
                if (!postInstance)
                    return response.status = 404
                renderThis(postInstance, request.getHeader("Accept"))
                break
            case "PUT":
                def postId = params.id
                def postInstance = postService.get(postId)
                if (!postInstance) {
                    render(status: 404, text: "Le post n'a pas été trouvé")
                    return
                }

                def requestData = request.JSON

                // On remet à zéro seulement les champs non obligatoires
                postInstance.properties.each { propertyName, _ ->
                    // Liste des champs non obligatoires
                    def nonMandatoryFields = []

                    if (nonMandatoryFields.contains(propertyName) || params.containsKey(propertyName)) {
                        postInstance[propertyName] = null
                    }
                }

                // On met à jour avec les nouvelles données
                requestData.each { key, value ->
                    postInstance[key] = value
                }

                postInstance["lastUpdated"] = new Date()

                postInstance.save()
                renderThis(postInstance, request.getHeader("Accept"))
                break
            case "PATCH":
                if (!request.getHeader("Content-Type").contains("json"))
                    render(status: 400, text: "Le body doit être formaté en JSON")
                def postId = params.id
                def postInstance = postService.get(postId)
                if (!postInstance) {
                    return response.status = 404
                    render(status: 404, text: "Le post n'a pas été trouvé")
                }
                def requestData = request.JSON

                // On modifie les données
                requestData.each { key, value ->
                    postInstance[key] = value
                }

                postInstance.save()

                renderThis(postInstance, request.getHeader("Accept"))
                break
            case "DELETE":
                try {
                    postService.delete(params.id)
                    render(status: 204, text: "Le post a bien été supprimé")
                    return response.status = 204
                } catch (Exception e) {
                    render(status: 404, text: "Le post n'a pas été trouvé")
                    return response.status = 404
                }
                break
            default:
                return response.status = 405
                break
        }
        return response.status = 406
    }

    def posts() {
        switch (request.getMethod()) {
            case "GET":
                def posts = postService.list()
                renderThis(posts, request.getHeader("Accept"))
                return response.status = 200
                break
            case "POST":
                if (!request.getHeader("Content-Type").contains("json"))
                    render(status: 400, text: "Le body doit être formaté en JSON")
                def postInstance = new Community(request.getJSON())
                if (postInstance.validate()) {
                    userService.save(postInstance)
                    return response.status = 201
                }
                render(status: 400, text: "Une erreur est survenue pendant la sauvegarde du post")
                break
            default:
                return response.status = 405
                break
        }
        return response.status = 406
    }

    def message() {
        switch (request.getMethod()) {
            case "GET":
                if (!params.id)
                    return response.status = 400
                def messageInstance = messageService.get(params.id)
                if (!messageInstance)
                    return response.status = 404
                renderThis(messageInstance, request.getHeader("Accept"))
                break
            case "PUT":
                def messageId = params.id
                def messageInstance = messageService.get(messageId)
                if (!messageInstance) {
                    render(status: 404, text: "Le message n'a pas été trouvé")
                    return
                }

                def requestData = request.JSON

                // On remet à zéro seulement les champs non obligatoires
                messageInstance.properties.each { propertyName, _ ->
                    // Liste des champs non obligatoires
                    def nonMandatoryFields = []

                    if (nonMandatoryFields.contains(propertyName) || params.containsKey(propertyName)) {
                        messageInstance[propertyName] = null
                    }
                }

                // On met à jour avec les nouvelles données
                requestData.each { key, value ->
                    messageInstance[key] = value
                }

                messageInstance["lastUpdated"] = new Date()

                messageInstance.save()
                renderThis(messageInstance, request.getHeader("Accept"))
                break
            case "PATCH":
                if (!request.getHeader("Content-Type").contains("json"))
                    render(status: 400, text: "Le body doit être formaté en JSON")
                def messageId = params.id
                def messageInstance = messageService.get(messageId)
                if (!messageInstance) {
                    render(status: 404, text: "Le message n'a pas été trouvé")
                    return
                }
                def requestData = request.JSON

                // On modifie les données
                requestData.each { key, value ->
                    messageInstance[key] = value
                }

                messageInstance.save()

                renderThis(messageInstance, request.getHeader("Accept"))
                break
            case "DELETE":
                try {
                    messageService.delete(params.id)
                    render(status: 204, text: "Le message a bien été supprimé")
                    return response.status = 204
                } catch (Exception e) {
                    render(status: 404, text: "Le message n'a pas été trouvé")
                    return response.status = 404
                }
                break
            default:
                return response.status = 405
                break
        }
        return response.status = 406
    }

    def messages() {
        switch (request.getMethod()) {
            case "GET":
                def messages = messageService.list()
                renderThis(messages, request.getHeader("Accept"))
                return response.status = 200
                break
            case "POST":
                if (!request.getHeader("Content-Type").contains("json"))
                    render(status: 400, text: "Le body doit être formaté en JSON")
                def messageInstance = new Message(request.getJSON())
                if (messageInstance.validate()) {
                    messageService.save(messageInstance)
                    renderThis(messageInstance, request.getHeader("Accept"))
                    return response.status = 201
                }
                render(status: 400, text: "Une erreur est survenue pendant la sauvegarde de l'utilisateur")
                break
            default:
                return response.status = 405
                break
        }
        return response.status = 406
    }

    def renderThis(Object object, String accept) {
        switch (accept) {
            case "json":
            case "application/json":
            case "text/json":
                render object as JSON
                break
            case "xml":
            case "application/xml":
            case "text/xml":
                render object as XML
                break
            default:
                render(status: 400, text: "L'encodage demandé n'est pas supporté")
                break
        }

    }

    def deleteUserClean(User userInstance) {

        def memberOfCommunities = userInstance.communities*.id.toList()
        memberOfCommunities.each {
            Long id ->
                userInstance.removeFromCommunities(Community.get(id))
        }

        def communities = Community.findAllByAuthor(userInstance)
        communities.each {
            Community community ->
                def communityMembers = community.members*.id
                communityMembers.each {
                    Long communityMemberId ->
                        User.get(communityMemberId).removeFromCommunities(community)
                }
                community.delete()
        }

        def userFiles = CustomFile.findAllByAuthor(userInstance)
        userFiles.each { it.delete() }

        def messages = Message.findAllByAuthor(userInstance)
        messages.each { it.delete() }

        def posts = Post.findAllByAuthor(userInstance)
        posts.each { it.delete() }

        UserRole.removeAll(userInstance)

        userInstance.delete(flush: true)
    }

    def deleteCommunityClean(Community communityInstance) {
        def communityMembers = communityInstance.members*.id
        communityMembers.each {
            Long communityMemberId ->
                User.get(communityMemberId).removeFromCommunities(communityInstance)
        }
        communityInstance.delete(flush: true)
    }

}