package grails_reddit_mbds_23_24

class UrlMappings {

    static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/"(view:"/index")
        "500"(view:'/error')
        "403"(view:'/accessDenied')
        "404"(view:'/notFound')
    }
}
