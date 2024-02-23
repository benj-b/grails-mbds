<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'message.label', default: 'Message')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
    <div class="flex flex-col items-center mt-14">
        <h1 class="mb-4 text-4xl font-extrabold leading-none tracking-tight text-gray-900 md:text-5xl lg:text-6xl dark:text-white">Create Message</h1>
        <p class="mb-6 text-lg font-normal text-gray-500 lg:text-xl sm:px-16 xl:px-48 dark:text-gray-400">Message creation form.</p>


        <g:form controller="message" action="save" method="POST" class="max-w-md mx-auto">
            <div class="relative z-0 w-full mb-5 group">
                <label for="content" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Content*</label>
                <input type="text" name="content" id="content" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" placeholder="Prometheus" required>
            </div>
            <div class="relative z-0 w-full mb-5 group">
                <label for="score" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Score*</label>
                <input type="number" name="score" id="score" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" required>
            </div>

            <div class="relative z-0 w-full mb-5 group">
                <label for="post" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Post*</label>
                <g:select
                        id="post"
                        name="post"
                        class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                        from="${fr.mbds.reddit.Post.list()}"
                        optionValue="title"
                        optionKey="id"/>
            </div>

            <g:submitButton
                    name="create"
                    class="save text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm w-full sm:w-auto px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800"
                    value="${message(code: 'default.button.create.label', default: 'Create')}"/>
        </g:form>
    </div>
    </body>
</html>
