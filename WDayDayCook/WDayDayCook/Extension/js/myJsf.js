





var myJsf = {
    linkRecipeDtl: function(id){
//        var url = "linkRecipeDtl/"+id;
//        var url = "http://www.baidu.com";
//        document.location = url;
        
        WebViewJavascriptBridge.showDetailVcId('linkRecipeDtl', id);
    },
    
    linkAllComment: function()
    {
        WebViewJavascriptBridge.showAllComment();
    }
};
