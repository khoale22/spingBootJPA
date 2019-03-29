String.noLC = new Object
  ({the:1, a:1, an:1, and:1, or:1, but:1, aboard:1,
    about:1, above:1, across:1, after:1, against:1, along:1, 
    amid:1, among:1, around:1, another:1, as:1, at:1,
    be:1, before:1, behind:1, below:1, beneath:1, beside:1,
    besides:1, between:1, beyond:1, but:1, by:1, 'for':1,
    from:1, future:1, 'in':1, inside:1, into:1, is:1, like:1, minus:1,
    near:1, of:1, off:1, on:1, onto:1, opposite:1,
    outside:1, over:1, past:1, per:1, plus:1,
    regarding:1, since:1, than:1, through:1, to:1,
    toward:1, towards:1, under:1, underneath:1, unlike:1,
    until:1, up:1, upon:1, versus:1, via:1, 'with':1,
    within:1, without:1, when:1, where:1, were:1, went:1});

String.prototype.titleCase = function () {
  var parts = this.split(' ');
  if ( parts.length == 0 ) return '';

  var fixed = new Array();
  for ( var i in parts ) {
  try
  {
    var fix = '';
    if ( String.noLC[parts[i]] )
    {
      fix = parts[i].toLowerCase();
    }
    else if ( parts[i].match(/^([A-Z]\.)+$/i) )
    { // will mess up "i.e." and like
      fix = parts[i].toUpperCase();
    }
    else if ( parts[i].match(/^[^aeiouy]+$/i) )
    { // voweless words are almost always acronyms
      fix = parts[i].toUpperCase();
    }
    else
    {
      fix = parts[i].substr(0,1).toUpperCase() +
                 parts[i].substr(1,parts[i].length);
    }
    fixed.push(fix);
	}catch(e)
	{
		
	}
  }
  fixed[0] = fixed[0].substr(0,1).toUpperCase() +
                 fixed[0].substr(1,fixed[0].length);
  return fixed.join(' ');
}
