<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Accces Denied</title>
    <meta name="layout" content="main">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.2.0/flowbite.min.css" rel="stylesheet" />
</head>

<body>

<div class="flex flex-col justify-center items-center h-[calc(100%-1rem)]">
    <h1 class="mb-4 text-4xl font-extrabold leading-none tracking-tight text-gray-900 md:text-5xl lg:text-6xl dark:text-white">404 <span class="underline underline-offset-3 decoration-8 decoration-blue-400 dark:decoration-blue-600">Not found</span></h1>
    <p class="text-lg font-normal text-gray-500 lg:text-xl dark:text-gray-400">Sorry but the page you are looking for does not exists. (${request.forwardURI})</p>
    <p class="text-lg font-normal text-gray-500 lg:text-xl dark:text-gray-400">You can go back to previous page or to the homepage.</p>
    <div class="pt-8 pb-8">
        <button type="button" onclick="goBack()" class="text-white bg-gradient-to-r from-cyan-500 to-blue-500 hover:bg-gradient-to-bl focus:ring-4 focus:outline-none focus:ring-cyan-300 dark:focus:ring-cyan-800 font-medium rounded-lg text-sm px-5 py-2.5 text-center me-2 mb-2">Previous page</button>
        <button onclick="navigateToIndex()" class="relative inline-flex items-center justify-center p-0.5 mb-2 me-2 overflow-hidden text-sm font-medium text-gray-900 rounded-lg group bg-gradient-to-br from-cyan-500 to-blue-500 group-hover:from-cyan-500 group-hover:to-blue-500 hover:text-white dark:text-white focus:ring-4 focus:outline-none focus:ring-cyan-200 dark:focus:ring-cyan-800">
            <span class="relative px-5 py-2.5 transition-all ease-in duration-75 bg-white dark:bg-gray-900 rounded-md group-hover:bg-opacity-0">
                Homepage
            </span>
        </button>
    </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.2.0/flowbite.min.js"></script>
<asset:javascript src="utils.js"/>

</body>
</html>