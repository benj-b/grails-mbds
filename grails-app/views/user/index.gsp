<%@ page import="fr.mbds.reddit.User" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>

    <div class="relative overflow-x-auto shadow-md sm:rounded-lg">
        <table class="w-full text-sm text-left rtl:text-right text-gray-500 dark:text-gray-400">
            <caption class="p-5 text-lg font-semibold text-left rtl:text-right text-gray-900 bg-white dark:text-white dark:bg-gray-800">
                Users
                <p class="mt-1 text-sm font-normal text-gray-500 dark:text-gray-400">Browse a list of Users, edit profiles, and more.</p>
                <button onclick="window.location.href = `/user/create`" class="save mt-4 cursor-pointer text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm w-full sm:w-auto px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800">
                    + Add User
                </button>
            </caption>
            <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
            <tr>
                <th scope="col" class="px-6 py-3">Username</th>
                <th scope="col" class="px-6 py-3">Email</th>
                <th scope="col" class="px-6 py-3">Bio</th>
                <th scope="col" class="px-6 py-3">Thumbnail</th>
                <th scope="col" class="px-6 py-3">Communities</th>
                <th scope="col" class="px-6 py-3">Files</th>
            </tr>
            </thead>
            <tbody>
            <g:each in="${fr.mbds.reddit.User.list()}" var="user">
                <tr onclick="redirectToShowPage('user', ${user.id})" class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-600 cursor-pointer">
                    <th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                        ${user.username}
                    </th>
                    <td class="px-6 py-4">
                        ${user.email}
                    </td>
                    <td class="px-6 py-4 overflow-hidden max-w-[300px]" style="text-overflow: ellipsis">
                        ${user.bio}
                    </td>
                    <td class="px-6 py-4">
                        <g:if test="${user.thumbnail}">
                            <img class="w-10 h-10 rounded-full"
                                 src="${grailsApplication.config.customFile.url + user.thumbnail.name}" alt="thumbnail">
                        </g:if>
                        <g:else>
                            <asset:image src="reddit-logo.svg" class="h-8" alt="Grails Logo"/>
                        </g:else>
                    </td>
                    <td class="px-6 py-4 text-right">
                        ${user.communities}
                    </td>
                    <td class="px-6 py-4 text-right">
                        ${user.files}
                    </td>
                </tr>
            </g:each>
            </tbody>
        </table>
    </div>





    </body>
</html>