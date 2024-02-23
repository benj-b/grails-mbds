<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'community.label', default: 'Community')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>


    <div class="pt-16 max-w-screen-xl" style="min-width: 1280px">
        <div class="flex flex-col items-center">
            <h1 class="mb-4 text-4xl font-extrabold leading-none tracking-tight text-gray-900 md:text-5xl lg:text-6xl dark:text-white">Show Community</h1>
            <p class="mb-6 text-lg font-normal text-gray-500 lg:text-xl sm:px-16 xl:px-48 dark:text-gray-400">Community's information.</p>
        </div>

        <div class="flex justify-center rounded-md mb-4" role="group">
            <g:link action="edit" resource="${this.community}" class="inline-flex items-center px-4 py-2 text-sm font-medium text-gray-900 bg-transparent border border-gray-900 rounded-s-lg hover:bg-gray-900 hover:text-white focus:z-10 focus:ring-2 focus:ring-gray-500 focus:bg-gray-900 focus:text-white dark:border-white dark:text-white dark:hover:text-white dark:hover:bg-gray-700 dark:focus:bg-gray-700">
                <svg class="w-3 h-3 me-2" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 20 18">
                    <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4.109 17H1v-2a4 4 0 0 1 4-4h.87M10 4.5a3.5 3.5 0 1 1-7 0 3.5 3.5 0 0 1 7 0Zm7.95 2.55a2 2 0 0 1 0 2.829l-6.364 6.364-3.536.707.707-3.536 6.364-6.364a2 2 0 0 1 2.829 0Z"/>
                </svg>
                Edit
            </g:link>
            <g:form resource="${this.community}" method="DELETE">
                <fieldset>
                    <button class="inline-flex items-center px-4 py-2 text-sm font-medium text-gray-900 bg-transparent border border-gray-900 rounded-e-lg hover:bg-gray-900 hover:text-white focus:z-10 focus:ring-2 focus:ring-gray-500 focus:bg-gray-900 focus:text-white dark:border-white dark:text-white dark:hover:text-white dark:hover:bg-gray-700 dark:focus:bg-gray-700"
                            type="submit"
                            onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">
                        <svg class="w-3 h-3 me-2" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 18 20">
                            <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M1 5h16M7 8v8m4-8v8M7 1h4a1 1 0 0 1 1 1v3H6V2a1 1 0 0 1 1-1ZM3 5h12v13a1 1 0 0 1-1 1H4a1 1 0 0 1-1-1V5Z"/>
                        </svg>
                        Delete
                    </button>
                </fieldset>
            </g:form>
        </div>


        <dl class="text-gray-900 divide-y divide-gray-200 dark:text-white dark:divide-gray-700 mb-4">
            <div class="flex flex-col pb-3">
                <dt class="mb-1 text-gray-500 md:text-lg dark:text-gray-400">Name</dt>
                <dd class="text-lg font-semibold">
                    <g:fieldValue bean="${community}" field="name"/>
                </dd>
            </div>

            <div class="flex flex-col pb-3">
                <dt class="mb-1 text-gray-500 md:text-lg dark:text-gray-400">Author</dt>
                <dd class="text-lg font-semibold">
                    <g:fieldValue bean="${community}" field="author.username"/>
                </dd>
            </div>

            <div class="flex flex-col py-3">
                <dt class="mb-1 text-gray-500 md:text-lg dark:text-gray-400">Description</dt>
                <dd class="text-lg font-semibold">
                    <g:fieldValue bean="${community}" field="description"/>
                </dd>
            </div>

            <div class="flex flex-col py-3">
                <dt class="mb-1 text-gray-500 md:text-lg dark:text-gray-400">Banner</dt>
                <dd class="text-lg font-semibold">
                    <g:fieldValue bean="${community}" field="banner"/>
                </dd>
            </div>

            <div class="flex flex-col py-3">
                <dt class="mb-1 text-gray-500 md:text-lg dark:text-gray-400">Thumbnail</dt>
                <dd class="text-lg font-semibold">
                    <g:fieldValue bean="${community}" field="thumbnail"/>
                </dd>
            </div>
        </dl>

        <dt class="mb-1 text-gray-500 md:text-lg dark:text-gray-400">Posts</dt>

        <div class="relative overflow-x-auto shadow-md sm:rounded-lg">
            <table class="w-full text-sm text-left rtl:text-right text-gray-500 dark:text-gray-400">
                <caption
                        class="p-5 text-lg font-semibold text-left rtl:text-right text-gray-900 bg-white dark:text-white dark:bg-gray-800">
                    Posts
                </caption>
                <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                <tr>
                    <th scope="col" class="px-6 py-3">
                        Title
                    </th>
                    <th scope="col" class="px-6 py-3">
                        Content
                    </th>
                    <th scope="col" class="px-6 py-3">
                        Score
                    </th>
                    <th scope="col" class="px-6 py-3">
                        Author
                    </th>
                </tr>
                </thead>
                <tbody>
                <g:each in="${community.posts}" var="post">
                    <tr onclick="redirectToShowPage('post', ${post.id})" class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-600 cursor-pointer">
                        <th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                            <g:fieldValue bean="${post}" field="title"/>
                        </th>

                        <th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white overflow-hidden max-w-xl" style="text-overflow: ellipsis;">
                            <g:fieldValue bean="${post}" field="content"/>
                        </th>

                        <th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                            <g:fieldValue bean="${post}" field="score"/>
                        </th>

                        <th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                            ${post.author.username}
                        </th>
                    </tr>
                </g:each>
                </tbody>
            </table>
        </div>

        <dt class="mb-1 text-gray-500 md:text-lg dark:text-gray-400">Members</dt>

        <div class="relative overflow-x-auto shadow-md sm:rounded-lg">
            <table class="w-full text-sm text-left rtl:text-right text-gray-500 dark:text-gray-400">
                <caption
                        class="p-5 text-lg font-semibold text-left rtl:text-right text-gray-900 bg-white dark:text-white dark:bg-gray-800">
                    Members
                </caption>
                <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                <tr>
                    <th scope="col" class="px-6 py-3">
                        Thumbnail
                    </th>
                    <th scope="col" class="px-6 py-3">
                        Username
                    </th>
                    <th scope="col" class="px-6 py-3">
                        email
                    </th>
                    <th scope="col" class="px-6 py-3">
                        bio
                    </th>
                </tr>
                </thead>
                <tbody>
                <g:each in="${community.members}" var="member">
                    <tr onclick="redirectToShowPage('user', ${member.id})" class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-600 cursor-pointer">
                        <th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                            <g:if test="${member.thumbnail}">
                                <img class="w-10 h-10 rounded-full"
                                     src="${grailsApplication.config.customFile.url + member.thumbnail.name}" alt="thumbnail">
                            </g:if>
                            <g:else>
                                <asset:image src="reddit-logo.svg" class="h-8" alt="Grails Logo"/>
                            </g:else>
                        </th>

                        <th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                            <g:fieldValue bean="${member}" field="username"/>
                        </th>

                        <th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                            <g:fieldValue bean="${member}" field="email"/>
                        </th>

                        <th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white overflow-hidden max-w-xl" style="text-overflow: ellipsis;"">
                            <g:fieldValue bean="${member}" field="bio"/>
                        </th>
                    </tr>
                </g:each>
                </tbody>
            </table>
        </div>

    </div>
    </body>
</html>
