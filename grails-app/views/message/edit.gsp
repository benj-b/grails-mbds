<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'message.label', default: 'Message')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
    <div id="edit-message" class="content scaffold-edit" role="main">
        <div class="mt-14 flex flex-col justify-center items-center">
            <h1 class="mb-4 mt-4 text-4xl font-extrabold leading-none tracking-tight text-gray-900 md:text-5xl lg:text-6xl dark:text-white">Edit Message</h1>
            <p class="mb-6 text-lg font-normal text-gray-500 lg:text-xl sm:px-16 xl:px-48 dark:text-gray-400">Edit message form.</p>
        </div>

        <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
        </g:if>
        <g:hasErrors bean="${this.message}">
            <ul class="errors" role="alert">
                <g:eachError bean="${this.message}" var="error">
                    <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                            error="${error}"/></li>
                </g:eachError>
            </ul>
        </g:hasErrors>

        <g:form resource="${this.message}" method="PUT">
            <g:hiddenField name="version" value="${this.message?.version}"/>
            <fieldset class="form">
                <div class="relative z-0 w-full mb-5 group">
                    <label for="content"
                           class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Title*</label>
                    <input type="text" name="content" id="content"
                           class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                           value="${this.message.content}" required>
                </div>

                <div class="relative z-0 w-full mb-5 group">
                    <label for="content" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Score*</label>
                    <input type="number" name="score" id="score"
                           class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                           value="${this.message.score}" required>
                </div>

                <div class="relative z-0 w-full mb-5 group">
                    <label for="post"
                           class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Post*</label>
                    <g:select
                            id="post"
                            name="post"
                            class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                            from="${fr.mbds.reddit.Post.list()}"
                            optionValue="title"
                            optionKey="id"/>
                </div>

            </fieldset>
            <fieldset class="flex flex-col justify-center items-center mt-4">
                <input type="submit"
                       class="save text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm w-full sm:w-auto px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800"
                       value="${message(code: 'default.button.update.label', default: 'Update')}"/>
            </fieldset>
        </g:form>

    </div>


    </body>
</html>
