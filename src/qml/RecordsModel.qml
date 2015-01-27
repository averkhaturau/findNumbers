import QtQuick 2.3

ListModel{
    id: recordsModel
    function addItem(rec){
        for(var i=0; i<recordsModel.count; ++i)
            if (recordsModel.get(i).playSize > rec.playSize ||
                    (recordsModel.get(i).playSize === rec.playSize && recordsModel.get(i).playTime >= rec.playTime)){
                break
            }
        recordsModel.insert(i, rec)
    }
}
