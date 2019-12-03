
function fileFormatFromPath(path){
    return path.substring(
                path.lastIndexOf(".")+1,
                path.length)
}

function isImage(path){
    var f = fileFormatFromPath(path)
    return f==="png" || f==="jpeg"  || f==="jpg" || f==="svg" || f==="gif"
}
function isMedia(path){
    var f = fileFormatFromPath(path)
    return f==="mp4" || f==="avi" || f==="mov" || f==="mkv" || f==="wmv"
}

function isAppFile(path){
    var f = fileFormatFromPath(path)
    return f==="dpb"
}

function isAcceptableForDrop(path){
    return isImage(path) || isAppFile(path)
}
