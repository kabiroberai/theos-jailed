
__currentOS=$(sw_vers | awk '/ProductName:/ {print$2}')
__CFid=$1
__newID=$2;
__file=$3;

__convertToXML(){
  plutil -convert xml1 "$__file" | sed 's/Converted .*//' | sed -n ':a;N;$!ba;s/\n//g';
}

__convertToPlist(){
  plutil -convert binary1 "$__file" | sed 's/Converted .*//' | sed -n ':a;N;$!ba;s/\n//g';
}

__changeBundleID(){
  if [[ $__currentOS == "Mac" ]]; then
    /usr/libexec/PlistBuddy -c "Add :"$__CFid" string" "$__file"
    /usr/libexec/PlistBuddy -c "Set :"$__CFid" $__newID" "$__file"
    # plutil -replace $__CFid -string "$__newID" "$__file"
  elif [[ $__currentOS == "iPhone" ]]; then
    plutil -key $__CFid -value "$__newID" "$__file"
  else
    local old=$(awk "/$__CFid/ {getline;print$1}" "$__file" | sed -n '/^$/!{s/<[^>]*>//g;p;}');
    local new=$__newID
    sed -i '' -e "/$__CFid/,/string/ s/$old/$new/" "$__file"
fi
}

if [[ $__currentOS == "Mac" ]] ; then
  __changeBundleID;
else
  __convertToXML;
  __changeBundleID;
  __convertToPlist;
fi
#
