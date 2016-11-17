var User = {
    login: function() {
        $.colorbox({
            href: HTV.loginUrl,
            iframe: true, 
            width: "510px", 
            height: "480px"
        });
    },
    register: function() {
        $.colorbox({
            href: HTV.registerUrl,
            iframe: true, 
            width: "510px", 
            height: "480px"
        });
    }
    
};

module.exports = User;