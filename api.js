function getAPIRoot() {
	return '';
}

function API(token) {
    this.token = token;
    this.headers = {};
    this.headers.Authorization = ' Bearer ' + token;
}

API.prototype.createSlug = function(slug) {
  	let reqURL = getAPIRoot() + '/slug/create/';
	return postAPI(reqURL, slug, this.headers);
};

API.prototype.fetchSlugFile = function(slugID, url, dir) {
    let reqURL = getAPIRoot() + '/fs/slug/' + slugID + '/fetch/file/';
	return postAPI(reqURL, {url, dir}, this.headers, 300000);
};

API.prototype.createSlugMySQL= function(slugID) {
    let reqURL = getAPIRoot() + '/mysql/create/';
	return postAPI(reqURL, {slugID}, this.headers);
};


API.prototype.getSlugMySQL = function(slugID) {
	let reqURL = getAPIRoot() + '/slug/' + slugID + '/metas/';
	return getAPI(reqURL, this.headers).then(metas => {
		return metas.filter(meta => meta.section === 'mysql');
	});
};

API.prototype.runSlugSQL = function(slugID, url) {
    let reqURL = getAPIRoot() + '/mysql/run/';
	return postAPI(reqURL, {url, slugID}, this.headers);
};

API.prototype.composeSlugTextFile = function(slugID, url, dir, model) {
    let reqURL = getAPIRoot() + '/fs/slug/' + slugID + '/compose/file/';
	return postAPI(reqURL, {url, dir, model}, this.headers, 200000);
};

API.prototype.startupSlug = function(slugID) {
    let reqURL = getAPIRoot() + '/slug/startup/';
	return postAPI(reqURL, {slugID}, this.headers);
};


API.prototype.shutdownSlug = function(slugID) {
    let reqURL = getAPIRoot() + '/slug/startup/';
	return postAPI(reqURL, {slugID}, this.headers);
};


var API_TIMEOUT = 30000;

function postAPI (url, data, exheaders, timeout) {
	return _postJSON(url, data, exheaders, timeout).then(resp => {
		return resp.data;
	}).catch(err => {
		console.log('eror postJSON->url:%s %o', url, err);
		let resp = err.response;
		if (resp) {
			let status = resp.status;
			if (status === 422) {
				if (resp.data.errors) {
					let message = resp.data.errors[0].msg;
					throw message; 
				}
			}
		}
		throw err;
	});
};

function getAPI(url , exheaders, timeout){
	return _getJSON(url, exheaders, timeout).then(resp => {
		return resp.data;
	}).catch(err => {
		console.log('eror postJSON->url:%s %o', url, err);
		let resp = err.response;
		if (resp) {
			let status = resp.status;
			if (status === 422) {
				if (resp.data.errors) {
					let message = resp.data.errors[0].msg;
					throw message; 
				}
			}
		}
		
		throw err;
	});
}


function _postJSON(url, data, exheaders, timeout) {

	
	let headers = {
		'Accept': 'application/json',
		'Content-Type': 'application/json',
	};
	let method = 'post';

	if (exheaders) {
		headers = Object.assign({}, headers, exheaders);
	}
		
	return axios(
		{
			url,
			method,
			headers,
			timeout,
			data,
		});

}

function _getJSON(url, exheaders, timeout) {


	let headers = {
		'Accept': 'application/json',
		'Content-Type': 'application/json',
	};
	let method = 'get';

	if (exheaders) {
		headers = Object.assign({}, headers, exheaders);
	}
		
	return axios(
		{
			url,
			method,
			headers,
			timeout,
		});
}