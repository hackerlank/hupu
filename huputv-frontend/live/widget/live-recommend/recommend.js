(function() {
  var slide = {
    init: function() {
      this.wrap = $('.live-recommend');
      this.leftBtn = $('#J_leftArrow');
      this.rightBtn = $('#J_rightArrow');
      this.list = this.wrap.find('ul');
      this.item = this.list.find('li');
      this.cur = 0;
      this.max = this.item.length;
      this.slideWid = this.item.outerWidth(true);
      this.calcMax();

      this.bind();
    },
    calcMax: function(){
      var max = this.item.length;
      var viewWidth = this.wrap.width();
      var viewCount = Math.round(viewWidth / this.slideWid);
      this.max = max - viewCount + 1;
    },
    bind: function() {
      var self = this;
      $(window).on("resize", self.calcMax.bind(self));

      this.leftBtn.on('click', function() {
        if (self.cur <= 0) {
          return;
        }
        self.cur--;

        self.list.animate({
            left: -self.slideWid * self.cur + 'px'
          },
          450,
          function() {

          });
      })

      this.rightBtn.on('click', function() {
        if (self.cur >= self.max - 1) {
          return;
        }
        self.cur++;

        self.list.animate({
            left: -self.slideWid * self.cur + 'px'
          },
          450,
          function() {

          });
      })
    }
  };

  slide.init();

})()
