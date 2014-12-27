
var mainBgColor = 'black';
var mainFrColor = 'white'
var actionBarColor = "gray"

var fontFamily = "Segoe UI"

function scaled(x) {
    return Math.round(x * scaleRatio);
}

function findInListModel(lm, pred){
    for (var i=0; i< lm.count; ++i)
        if (pred(lm.get(i)))
            return i
    return -1
}

function shuffle(array) {
    var currentIndex = array.length, temporaryValue, randomIndex ;

    // While there remain elements to shuffle...
    while (0 !== currentIndex) {

        // Pick a remaining element...
        randomIndex = Math.floor(Math.random() * currentIndex);
        currentIndex -= 1;

        // And swap it with the current element.
        temporaryValue = array[currentIndex];
        array[currentIndex] = array[randomIndex];
        array[randomIndex] = temporaryValue;
    }

    return array;
}

function generateIntArray(n){
    var myArray = []
    for (var i=0; i<n; ++i)
        myArray[i] = i+1;
    return myArray;
}

function deserializeListModel(str, model) {
    if(str !== "")
    {
        console.log("Parsing json " + str)
        try{
            var objectArray = JSON.parse(str);
            if (typeof objectArray.errors === "Array")
            {
                console.log("loadFavoritesModelFromSettings Error: " + objectArray.errors[0].message)
            }
            else
            {
                for (var indx in objectArray.result)
                {
                    model.append(objectArray.result[indx]);
                }
            }
        }catch(ee){
            console.log(ee)
        }
    }
    // favoritesModel.onCountChanged.connect(saveFavoritesModelToSettings)
}

function serializeListModel(model){
    if (model.count === 0){
        return ""
    }
    else {
        var fullStr = "{\"result\":[ "
        for(var i = 0; i < model.count; ++i)
        {
            var obj = model.get(i)
            var str = JSON.stringify(obj)
            fullStr += str + ","
        }
        fullStr = fullStr.slice(0,-1) // remove last ','
        fullStr +="]}"

        return fullStr
    }
}

