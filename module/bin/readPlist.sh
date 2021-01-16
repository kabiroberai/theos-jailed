
__currentOS=$(sw_vers | awk '/ProductName:/ {print$2}')
__readID=$1;
__file=$2;
__result="";

__convertToXML(){
  plutil -convert xml1 "$__file" | sed 's/Converted .*//' | sed -n ':a;N;$!ba;s/\n//g';
}

__convertToPlist(){
  plutil -convert binary1 "$__file" | sed 's/Converted .*//' | sed -n ':a;N;$!ba;s/\n//g';
}

__readFromPlist(){
  if [[ $__currentOS == "Mac" ]]; then
      local data=$(/usr/libexec/PlistBuddy -c "Print :$__readID" "$__file")
      __result="$data"
  elif [[ $__currentOS == "iPhone" ]]; then
      local data=$(plutil -key "$__readID" "$__file");
      __result="$data"
  else
      local data=`awk "/$__readID/ {getline;print$1}" "$__file" | sed  -E "s/[[:space:]]+//" | sed -n '/^$/!{s/<[^>]*>//g;p;}'`;
      __result="$data";
  fi
}

if [[ $__currentOS == "Mac" ]] || [[ $__currentOS == "iPhone" ]]
  then
    __readFromPlist;
else
  __convertToXML;
  __readFromPlist;
  __convertToPlist;
fi


# result=$(__readFromPlist)
echo "$__result";
