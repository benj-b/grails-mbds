const goBack = () => window.history.back();
const navigateToIndex = (baseUrl) => window.location.href = '/';
const redirectToShowPage = (page, id) => window.location.href =`/${page}/show/${id}`;