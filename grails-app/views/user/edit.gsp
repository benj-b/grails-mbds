<!DOCTYPE html>
<html>
<head>
		<meta name="layout" content="main"/>
		<g:set var="entityName" value="${message(code: 'user.label', default: 'User')}"/>
		<title><g:message code="default.edit.label" args="[entityName]"/></title>
</head>

<body>
<div id="edit-user" class="content scaffold-edit" role="main">
		<div class="flex flex-col justify-center items-center">
				<h1 class="mb-4 mt-4 text-4xl font-extrabold leading-none tracking-tight text-gray-900 md:text-5xl lg:text-6xl dark:text-white">Edit User</h1>
				<p class="mb-6 text-lg font-normal text-gray-500 lg:text-xl sm:px-16 xl:px-48 dark:text-gray-400">Edit user form.</p>
		</div>

		<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
		</g:if>
		<g:hasErrors bean="${this.user}">
				<ul class="errors" role="alert">
						<g:eachError bean="${this.user}" var="error">
								<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
												error="${error}"/></li>
						</g:eachError>
				</ul>
		</g:hasErrors>



		<g:form resource="${this.user}" method="PUT">
				<g:hiddenField name="version" value="${this.user?.version}"/>
				<fieldset class="form">
						<div class="relative z-0 w-full mb-5 group">
								<label for="password"
											 class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Password*</label>
								<input type="password" name="password" id="password"
											 class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
											 required>
						</div>

						<div class="relative z-0 w-full mb-5 group">
								<label for="email"
											 class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Username*</label>
								<input type="text" name="username" id="username"
											 class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
											 value="${this.user.username}" required>
						</div>

						<div class="relative z-0 w-full mb-5 group">
								<label for="email" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Email*</label>
								<input type="email" name="email" id="email"
											 class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
											 value="${this.user.email}" required>
						</div>

						<div class="relative z-0 w-full mb-5 group">
								<label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Bio</label>
								<input type="text" name="bio" id="bio"
											 class="block w-full p-4 text-gray-900 border border-gray-300 rounded-lg bg-gray-50 sm:text-md focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
											 value="${this.user.bio}">
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
								<label for="communities"
											 class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Communities</label>
								<g:select
												multiple=""
												id="communities"
												name="communities"
												class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
												from="${fr.mbds.reddit.Community.list()}"
												optionValue="name"
												optionKey="id"/>
						</div>

						<div class="flex items-center ps-4 border border-gray-200 rounded dark:border-gray-700">
								<g:checkBox
										id="passExpired"
										value="${this.user.passwordExpired}"
										checked="${this.user.passwordExpired}"
										class="w-4 h-4 text-blue-600 bg-gray-100 border-gray-300 rounded focus:ring-blue-500 dark:focus:ring-blue-600 dark:ring-offset-gray-800 focus:ring-2 dark:bg-gray-700 dark:border-gray-600"
										name="passExpired"
								/>
								<label for="passExpired" class="w-full py-4 ms-2 text-sm font-medium text-gray-900 dark:text-gray-300">Password expired</label>
						</div>

						<div class="flex items-center ps-4 border border-gray-200 rounded dark:border-gray-700">
								<g:checkBox
												id="accountExpired"
												value="${this.user.accountExpired}"
												checked="${this.user.accountExpired}"
												class="w-4 h-4 text-blue-600 bg-gray-100 border-gray-300 rounded focus:ring-blue-500 dark:focus:ring-blue-600 dark:ring-offset-gray-800 focus:ring-2 dark:bg-gray-700 dark:border-gray-600"
												name="accountExpired"
								/>
								<label for="accountExpired" class="w-full py-4 ms-2 text-sm font-medium text-gray-900 dark:text-gray-300">Account expired</label>
						</div>

						<div class="flex items-center ps-4 border border-gray-200 rounded dark:border-gray-700">
								<g:checkBox
												id="accountLocked"
												value="${this.user.accountLocked}"
												checked="${this.user.accountLocked}"
												class="w-4 h-4 text-blue-600 bg-gray-100 border-gray-300 rounded focus:ring-blue-500 dark:focus:ring-blue-600 dark:ring-offset-gray-800 focus:ring-2 dark:bg-gray-700 dark:border-gray-600"
												name="accountLocked"
								/>
								<label for="accountLocked" class="w-full py-4 ms-2 text-sm font-medium text-gray-900 dark:text-gray-300">Account locked</label>
						</div>

						<div class="flex items-center ps-4 border border-gray-200 rounded dark:border-gray-700">
								<g:checkBox
												id="enabled"
												value="${this.user.enabled}"
												checked="${this.user.enabled}"
												class="w-4 h-4 text-blue-600 bg-gray-100 border-gray-300 rounded focus:ring-blue-500 dark:focus:ring-blue-600 dark:ring-offset-gray-800 focus:ring-2 dark:bg-gray-700 dark:border-gray-600"
												name="enabled"
								/>
								<label for="passExpired" class="w-full py-4 ms-2 text-sm font-medium text-gray-900 dark:text-gray-300">Enabled</label>
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
