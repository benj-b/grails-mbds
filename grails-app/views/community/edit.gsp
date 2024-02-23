<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'community.label', default: 'Community')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
    <div id="edit-community" class="content scaffold-edit" role="main">
        <div class="flex flex-col justify-center items-center">
            <h1 class="mb-4 mt-4 text-4xl font-extrabold leading-none tracking-tight text-gray-900 md:text-5xl lg:text-6xl dark:text-white">Edit Community</h1>
            <p class="mb-6 text-lg font-normal text-gray-500 lg:text-xl sm:px-16 xl:px-48 dark:text-gray-400">Edit community form.</p>
        </div>

        <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
        </g:if>
        <g:hasErrors bean="${this.community}">
            <ul class="errors" role="alert">
                <g:eachError bean="${this.community}" var="error">
                    <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                            error="${error}"/></li>
                </g:eachError>
            </ul>
        </g:hasErrors>

        <g:form resource="${this.community}" method="PUT">
            <g:hiddenField name="version" value="${this.community?.version}"/>
            <fieldset class="form">
                <div class="relative z-0 w-full mb-5 group">
                    <label for="name"
                           class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Name*</label>
                    <input type="text" name="name" id="name"
                           class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                           value="${this.community.name}" required>
                </div>

                <div class="relative z-0 w-full mb-5 group">
                    <label for="description" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Description</label>
                    <input type="text" name="description" id="description"
                           class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                           value="${this.community.description}" required>
                </div>

                <div class="relative z-0 w-full mb-5 group">
                    <label for="banner"
                           class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Banner</label>
                    <g:select
                            id="banner"
                            name="banner"
                            class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                            from="${fr.mbds.reddit.CustomFile.list()}"
                            optionValue="name"
                            optionKey="id"/>
                </div>

                <div class="relative z-0 w-full mb-5 group">
                    <label for="thumbnail"
                           class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Thumbnail</label>
                    <g:select
                            id="thumbnail"
                            name="thumbnail"
                            class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                            from="${fr.mbds.reddit.CustomFile.list()}"
                            optionValue="name"
                            optionKey="id"/>
                </div>

                <div class="relative z-0 w-full mb-5 group">
                    <label for="post"
                           class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Post</label>
                    <div id="post" onclick="window.location.href = `/post/create?community.id=${this.community.id}`" class="save cursor-pointer text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm w-full sm:w-auto px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800">
                        Add Post
                    </div>

                </div>

                <div class="relative z-0 w-full mb-5 group">
                    <label for="members"
                           class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Members</label>
                    <g:select
                            multiple=""
                            id="members"
                            name="members"
                            class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                            from="${fr.mbds.reddit.User.list()}"
                            optionValue="username"
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
