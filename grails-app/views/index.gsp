<%
    def controllerConfig = grailsApplication.config.controllerConfig
%>

<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Welcome to Grails</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.2.0/flowbite.min.css" rel="stylesheet" />
</head>
<body>
    <content tag="nav">
        <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Application Status <span class="caret"></span></a>
            <ul class="dropdown-menu">
                <li><a href="#">Environment: ${grails.util.Environment.current.name}</a></li>
                <li><a href="#">App profile: ${grailsApplication.config.grails?.profile}</a></li>
                <li><a href="#">App version:
                    <g:meta name="info.app.version"/></a>
                </li>
                <li role="separator" class="divider"></li>
                <li><a href="#">Grails version:
                    <g:meta name="info.app.grailsVersion"/></a>
                </li>
                <li><a href="#">Groovy version: ${GroovySystem.getVersion()}</a></li>
                <li><a href="#">JVM version: ${System.getProperty('java.version')}</a></li>
                <li role="separator" class="divider"></li>
                <li><a href="#">Reloading active: ${grails.util.Environment.reloadingAgentEnabled}</a></li>
            </ul>
        </li>
        <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Artefacts <span class="caret"></span></a>
            <ul class="dropdown-menu">
                <li><a href="#">Controllers: ${grailsApplication.controllerClasses.size()}</a></li>
                <li><a href="#">Domains: ${grailsApplication.domainClasses.size()}</a></li>
                <li><a href="#">Services: ${grailsApplication.serviceClasses.size()}</a></li>
                <li><a href="#">Tag Libraries: ${grailsApplication.tagLibClasses.size()}</a></li>
            </ul>
        </li>
        <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Installed Plugins <span class="caret"></span></a>
            <ul class="dropdown-menu">
                <g:each var="plugin" in="${applicationContext.getBean('pluginManager').allPlugins}">
                    <li><a href="#">${plugin.name} - ${plugin.version}</a></li>
                </g:each>
            </ul>
        </li>
    </content>

    <div id="content" role="main" class="max-w-screen-xl" style="min-width: 1280px">
        <section class="row colset-2-its">

            <div class="pt-20 pb-16 flex items-center flex-col">
                <h1 class="mb-4 text-3xl font-extrabold text-gray-900 dark:text-white md:text-5xl lg:text-6xl"><span class="text-transparent bg-clip-text bg-gradient-to-r to-emerald-600 from-sky-400">GReddit</span> A Spez free API.</h1>
                <p class="text-lg font-normal text-gray-500 lg:text-xl dark:text-gray-400">Here at GReddit we focus on being a sketchy and questionnable Reddit API like.</p>
            </div>

            <div id="controllers" role="navigation">
                <h2 class="mb-4 text-4xl font-extrabold leading-none tracking-tight text-gray-900 dark:text-white">Available <mark class="px-2 text-white bg-blue-600 rounded dark:bg-blue-500">Controllers</mark>.</h2>
                <div class="grid grid-cols-2 md:grid-cols-3 gap-4">
                    <g:each var="c" in="${grailsApplication.controllerClasses.sort { it.fullName } }">
                        <g:if test="${['UserController', 'CommunityController', 'PostController', 'MessageController', 'CustomFileController'].contains(c.shortName)}">
                            <div class="w-full max-w-full bg-white border border-gray-200 rounded-lg shadow dark:bg-gray-800 dark:border-gray-700">
                                <div class="flex justify-end px-4 pt-4">
                                </div>
                                <div class="flex flex-col items-center pb-10">
                                    <asset:image class="w-24 h-24 mb-3 rounded-full shadow-lg" src="user.svg" alt="Bonnie image"/>
                                    <h5 class="mb-1 text-xl font-medium text-gray-900 dark:text-white">${c.shortName}</h5>
                                    <span class="text-sm text-gray-500 dark:text-gray-400">Visual Designer</span>
                                    <div class="flex mt-4 md:mt-6">
                                        <g:link controller="${c.logicalPropertyName}" class="inline-flex items-center px-4 py-2 text-sm font-medium text-center text-white bg-blue-700 rounded-lg hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800">Controller</g:link>
                                    </div>
                                </div>
                            </div>
                        </g:if>
                    </g:each>
                </div>
            </div>
        </section>
    </div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.2.0/flowbite.min.js"></script>
</body>
</html>
