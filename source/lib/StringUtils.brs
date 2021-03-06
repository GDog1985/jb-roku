'' If you import this, you also need to import Types
'' (for isstr)
''
'' Functions in this file:
''	isnonemptystr
''	isnullorempty
''	strtobool
''	itostr
''	strTrim
''	strTokenize
''	strReplace     

'******************************************************
'isnonemptystr
'
'Determine if the given object supports the ifString interface
'and returns a string of non zero length
'******************************************************
Function isnonemptystr(obj)
	if isnullorempty(obj) return false
	return true
End Function

'******************************************************
'isnullorempty
'
'Determine if the given object is invalid or supports
'the ifString interface and returns a string of non zero length
'******************************************************
Function isnullorempty(obj)
	if obj = invalid return true
	if not isstr(obj) return true
 	if Len(obj) = 0 return true
	return false
End Function

'******************************************************
'strtobool
'
'Convert string to boolean safely. Don't crash
'Looks for certain string values
'******************************************************
Function strtobool(obj As dynamic) As Boolean
	if obj = invalid return false
	if type(obj) <> "roString" and type(obj) <> "String" return false
	o = strTrim(obj)
	o = Lcase(o)
	if o = "true" return true
	if o = "t" return true
	if o = "y" return true
	if o = "1" return true
	return false
End Function

'******************************************************
'itostr
'
'Convert int to string. This is necessary because
'the builtin Stri(x) prepends whitespace
'******************************************************
Function itostr(i As Integer) As String
	str = Stri(i)
	return strTrim(str)
End Function

'******************************************************
'Trim a string
'******************************************************
Function strTrim(str As String) As String
	st=CreateObject("roString")
	st.SetString(str)
	return st.Trim()
End Function

'******************************************************
'Tokenize a string. Return roList of strings
'******************************************************
Function strTokenize(str As String, delim As String) As Object
	st=CreateObject("roString")
	st.SetString(str)
	return st.Tokenize(delim)
End Function

' Regex string replacement functions
Function regexReplace( inputstr As String, regex As String, replacement As String, regexops As String ) As String
	r = CreateObject( "roRegex", ValidStr( regex ), ValidStr( regexops ) )
	return r.Replace( inputstr, ValidStr( replacement ) )
End Function

Function regexReplaceAll( inputstr As String, regex As String, replacement As String, regexops As String ) As String
	r = CreateObject( "roRegex", ValidStr( regex ), ValidStr( regexops ) )
	return r.ReplaceAll( inputstr, ValidStr( replacement ) )
End Function

'******************************************************
'Replace substrings in a string. Return new string
'******************************************************
Function strReplace(basestr As String, oldsub As String, newsub As String) As String
	newstr = ""
	i = 1
	while i <= Len(basestr)
		x = Instr(i, basestr, oldsub)
		if x = 0 then
			newstr = newstr + Mid(basestr, i)
			exit while
		endif

		if x > i then
			newstr = newstr + Mid(basestr, i, x-i)
			i = x
		endif

		newstr = newstr + newsub
		i = i + Len(oldsub)
	end while
	return newstr
End Function
