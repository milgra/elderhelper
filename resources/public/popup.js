function getConfirmation(text,url) {
    var retVal = confirm(text);
    if( retVal == true ) {
	document.location.href = url;
	return true;
    } else {
        return false;
    }
}
