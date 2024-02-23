<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'post.label', default: 'Post')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
    <div class="relative overflow-x-auto shadow-md sm:rounded-lg" style="min-width: 100%">
        <table class="w-full text-sm text-left rtl:text-right text-gray-500 dark:text-gray-400">
            <caption class="p-5 text-lg font-semibold text-left rtl:text-right text-gray-900 bg-white dark:text-white dark:bg-gray-800">
                Users
                <p class="mt-1 text-sm font-normal text-gray-500 dark:text-gray-400">Browse a list of Posts, edit, and more.</p>
                <button onclick="window.location.href = `/post/create`" class="save mt-4 cursor-pointer text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm w-full sm:w-auto px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800">
                    + Add Post
                </button>
            </caption>
            <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
            <tr>
                <th scope="col" class="px-6 py-3">Title</th>
                <th scope="col" class="px-6 py-3">Content</th>
                <th scope="col" class="px-6 py-3">Score</th>
                <th scope="col" class="px-6 py-3">Author</th>
                <th scope="col" class="px-6 py-3">Files</th>
                <th scope="col" class="px-6 py-3">Community</th>
                <th scope="col" class="px-6 py-3">Messages</th>
            </tr>
            </thead>
            <tbody>
            <g:each in="${fr.mbds.reddit.Post.list()}" var="post">
                <tr onclick="redirectToShowPage('post', ${post.id})" class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-600 cursor-pointer">
                    <th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                        ${post.title}
                    </th>
                    <td class="px-6 py-4 overflow-hidden max-w-[300px]" style="text-overflow: ellipsis">
                        ${post.content}
                    </td>
                    <td class="px-6 py-4 overflow-hidden max-w-[300px]" style="text-overflow: ellipsis">
                        ${post.score}
                    </td>
                    <td class="px-6 py-4 overflow-hidden max-w-[300px]" style="text-overflow: ellipsis">
                        ${post.author}
                    </td>
                    <td class="px-6 py-4 overflow-hidden max-w-[300px]" style="text-overflow: ellipsis">
                        ${post.files}
                    </td>
                    <td class="px-6 py-4 overflow-hidden max-w-[300px]" style="text-overflow: ellipsis">
                        ${post.community.name}
                    </td>
                    <td class="px-6 py-4 overflow-hidden max-w-[300px]" style="text-overflow: ellipsis">
                        ${post.messages}
                    </td>
                </tr>
            </g:each>
            </tbody>
        </table>
    </div>
    </body>
</html>