<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'customFile.label', default: 'CustomFile')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
<body>
<div id="edit-customFile" class="content scaffold-edit" role="main">
    <div class="flex flex-col justify-center items-center">
        <h1 class="mb-4 mt-4 text-4xl font-extrabold leading-none tracking-tight text-gray-900 md:text-5xl lg:text-6xl dark:text-white">Edit customFile</h1>
        <p class="mb-6 text-lg font-normal text-gray-500 lg:text-xl sm:px-16 xl:px-48 dark:text-gray-400">Edit customFile form.</p>
    </div>

    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${this.customFile}">
        <ul class="errors" role="alert">
            <g:eachError bean="${this.customFile}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                        error="${error}"/></li>
            </g:eachError>
        </ul>
    </g:hasErrors>

    <g:form resource="${this.customFile}" method="PUT">
        <g:hiddenField name="version" value="${this.customFile?.version}"/>
        <fieldset class="form">
            <div class="relative z-0 w-full mb-5 group">
                <label for="name"
                       class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Name*</label>
                <input type="text" name="name" id="name"
                       class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                       value="${this.customFile.name}" required>
            </div>

            <div class="relative z-0 w-full mb-5 group">
                <label for="fileInput" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">File</label>
                <input type="file" name="fileInput" id="fileInput" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" accept="image/*" />
            </div>

            <div class="relative z-0 w-full mb-5 group">
                <label for="type" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Type</label>
                <g:select
                        id="type"
                        name="type"
                        class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                        from="${fr.mbds.reddit.CustomFileType.values()*.name()}"
                        value="${this.customFile?.type?.name()}" />
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
