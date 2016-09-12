





var myJsf = {
    linkRecipeDtl: function(id){
//        var url = "linkRecipeDtl/"+id;
//        var url = "wangju://6666666";
//        document.location = url;
        
        WebViewJavascriptBridge.showDetailVcId('linkRecipeDtl', id);
    },
    
    linkAllComment: function()
    {
        WebViewJavascriptBridge.showAllComment();
    }
};
