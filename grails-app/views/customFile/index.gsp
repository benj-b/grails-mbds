<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'customFile.label', default: 'CustomFile')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
    <div class="relative overflow-x-auto shadow-md sm:rounded-lg" style="min-width: 100%">
        <table class="w-full text-sm text-left rtl:text-right text-gray-500 dark:text-gray-400">
            <caption class="p-5 text-lg font-semibold text-left rtl:text-right text-gray-900 bg-white dark:text-white dark:bg-gray-800">
                CustomFiles
                <p class="mt-1 text-sm font-normal text-gray-500 dark:text-gray-400">Browse a list of CustomFiles, edit, and more.</p>
                <button onclick="window.location.href = `/customFile/create`" class="save mt-4 cursor-pointer text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm w-full sm:w-auto px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800">
                    + Add CustomFile
                </button>
            </caption>
            <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
            <tr>
                <th scope="col" class="px-6 py-3">Name</th>
                <th scope="col" class="px-6 py-3">Type</th>
                <th scope="col" class="px-6 py-3">Author</th>
            </tr>
            </thead>
            <tbody>
            <g:each in="${fr.mbds.reddit.CustomFile.list()}" var="file">
                <tr onclick="redirectToShowPage('post', ${file.id})" class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-600 cursor-pointer">
                    <td class="px-6 py-4 overflow-hidden max-w-[300px]" style="text-overflow: ellipsis">
                        ${file.name}
                    </td>
                    <td class="px-6 py-4 overflow-hidden max-w-[300px]" style="text-overflow: ellipsis">
                        ${file.type}
                    </td>
                    <td class="px-6 py-4 overflow-hidden max-w-[300px]" style="text-overflow: ellipsis">
                        ${file.author}
                    </td>
                </tr>
            </g:each>
            </tbody>
        </table>
    </div>


    </body>
</html>