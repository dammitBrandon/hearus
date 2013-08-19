/*
 *  Trip.js - A jQuery plugin that can help you customize your tutorial trip easily
 *  Version : 1.2.1
 *
 *  Author : EragonJ <eragonj@eragonj.me> 
 *  Blog : http://eragonj.me
 */
(function(window, $) {

    var Trip = function( tripData, userOptions ) {

        // save the settings
        this.settings = $.extend({

            // basic config
            tripIndex : 0,
            tripTheme : "black",
            backToTopWhenEnded : false,
            overlayZindex : 99999,
            delay : 1000,
            enableKeyBinding : true,
            showCloseBox : false,
            skipUndefinedTrip : false,

            // navigation
            showNavigation: false,
            canGoNext: true,
            canGoPrev: true,
        
            // labels
            nextLabel : "Next",
            prevLabel : "Back",
            finishLabel: "Dismiss",
            closeBoxLabel : '&#215;',

            // callbacks
            onTripStart : $.noop,
            onTripEnd : $.noop,
            onTripStop : $.noop,
            onTripChange : $.noop

        }, userOptions);

        // save the trip data
        this.tripData = tripData;

        // used SELs
        this.$tripBlock = null;
        this.$overlay = null;
        this.$bar = null;
        this.$root = $('body, html');

        // save the current trip index
        this.tripIndex = this.settings.tripIndex;
        this.tripDirection = 'next';
        this.timer = null;
        this.progressing = false;

        // about expose
        this.hasExpose = false;

        // contants
        this.CONSTANTS = {
            LEFT_ARROW : 37,
            UP_ARROW : 38,
            RIGHT_ARROW : 39,
            DOWN_ARROW : 40,
            ESC : 27,
            SPACE : 32
        };

        this.console = window.console || {};
    };

    Trip.prototype = {

        preInit : function() {

            // override console object for IE
            if ( typeof this.console === "undefined" ) {

                var self = this,
                    methods = ['log', 'warn', 'debug', 'info', 'error'];

                $.each(methods, function(i, methodName) {
                    self.console[methodName] = $.noop;
                });
            }
        },

        // TODO: implement expose
        showExpose : function( $sel ) {

            this.hasExpose = true;

            var oldCSS, 
                newCSS;

            oldCSS = {
                position : $sel.css('position'),
                zIndex : $sel.css('z-Index')
            };

            newCSS = {
                position : 'relative',
                zIndex : this.settings.overlayZindex + 1 // we have to make it higher than the overlay
            };

            $sel.data('trip-old-css', oldCSS)
                .css(newCSS)
                .addClass('trip-exposed');

            this.$overlay.show();
        },

        // TODO: implement expose
        hideExpose : function() {
            this.hasExpose = false;

            var $exposedSel = $('.trip-exposed'),
                oldCSS = $exposedSel.data('trip-old-css');

            $exposedSel.css( oldCSS )
                       .removeClass('trip-exposed');

            this.$overlay.hide();
        },

        bindKeyEvents : function() {
            var that = this;
            $(document).on({
                'keydown.Trip' : function(e) {
                    // `this` will be bound to #document DOM element here
                    that.keyEvent.call(that, e); 
                }
            });
        },

        unbindKeyEvents : function() {
            $(document).off('keydown.Trip');
        },

        keyEvent : function(e) {

            switch(e.which) {
            case this.CONSTANTS['ESC'] :

                this.stop();
                break;

            case this.CONSTANTS['SPACE'] : 

                // space will make the page jump
                e.preventDefault();
                this.pause();
                break;

            case this.CONSTANTS['LEFT_ARROW'] :
            case this.CONSTANTS['UP_ARROW'] :

                this.prev();
                break;

            case this.CONSTANTS['RIGHT_ARROW'] : 
            case this.CONSTANTS['DOWN_ARROW'] : 

                this.next();
                break;
            }
        },

        stop : function() {
            if (this.timer)
                this.timer.stop();

            if ( this.hasExpose ) {
                this.hideExpose();
            }

            this.tripIndex = this.settings.tripIndex;
            this.hideTripBlock();

            // exec cb
            this.settings.onTripStop();
        },

        pauseAndResume : function() {
            if ( this.progressing ) {
                this.timer.pause();
                this.pauseProgressBar();
            }
            else {
                var remainingTime = this.timer.resume();
                this.resumeProgressBar( remainingTime );
            }
            
            this.progressing = !this.progressing;
        },

        pause : function() {
            this.pauseAndResume();
        },

        resume : function() {
            this.pauseAndResume();
        },

        next : function() {
            this.tripDirection = 'next';

            if ( !this.canGoNext() ) {
                return this.run();
            }

            if ( this.hasCallback() ) {
                this.callCallback();
            }

            if ( this.isLast() ){
                this.doLastOperation();
            }
            else {
                this.increaseIndex();
                this.run();
            }
        },

        prev : function() {
            this.tripDirection = 'prev';

            if ( !this.isFirst() && this.canGoPrev() ) {
                this.decreaseIndex();
            }
            this.run();
        },

        // XXX:
        // Because the trip index is controlled by increaseIndex / decreaseIndex methods only, 
        // `showCurrentTrip` doesn't have to take care about which is the current trip object, 
        // it just does the necessary operations according to the passed tripData `o`
        showCurrentTrip : function(o) {

            // Allow sel element to be a string selector
            // in case you want to create a TripObject that
            // handles an element that doesn't exist yet when you create
            // this Trip.
            if(typeof o.sel === 'string') {
                o.sel = $(o.sel);
            }

            // preprocess when we have to show trip block
            if ( this.timer ) {
                this.timer.stop();
            }
            
            if ( this.hasExpose ) {
                this.hideExpose();
            }

            if ( this.progressing ) {

                this.hideProgressBar();

                // not doing the progress effect
                this.progressing = false;
            }

            this.setTripBlock(o);
            this.showTripBlock(o);

            if ( o.expose ) {
                this.showExpose( o.sel );
            }
        },

        doLastOperation : function() {
            if ( this.timer ) {
                this.timer.stop();
            }

            if ( this.settings.enableKeyBinding ) {
                this.unbindKeyEvents();
            }

            this.hideTripBlock();

            if ( this.hasExpose ) {
                this.hideExpose();
            }
            
            if ( this.settings.backToTopWhenEnded ) {
                this.$root.animate({ scrollTop : 0 }, 'slow');
            }

            this.tripIndex = this.settings.tripIndex;
            this.settings.onTripEnd();

            return false;
        },

        showProgressBar : function( delay ) {
            var that = this;

            this.$bar.animate({
                width : '100%'  
            }, delay, "linear", function() {
                that.$bar.width(0);
            });
        },

        hideProgressBar : function() {
            this.$bar.width(0);
            this.$bar.stop(true);
        },

        pauseProgressBar : function() {
            this.$bar.stop(true);
        },

        resumeProgressBar : function( remainingTime ) {
            this.showProgressBar( remainingTime );
        },

        run : function() {

            var that = this,
                tripObject = this.getCurrentTripObject(),
                delay = tripObject.delay || this.settings.delay;

            if ( !this.isTripDataValid( tripObject ) ) {

                // force developers to double check tripData again
                if ( this.settings.skipUndefinedTrip === false ) {
                    this.console.error("Your tripData is not valid at index : " + this.tripIndex);
                    this.stop();
                    return false; 
                }
                // let it go
                else {
                    return this[ this.tripDirection ]();
                }
            }

            this.showCurrentTrip( tripObject );

            // show the progress bar
            this.showProgressBar( delay );
            this.progressing = true;

            // set timer to show next, if the timer is less than zero we expect
            // it to be manually advanced
            if (delay >= 0) {
                this.timer = new Timer(that.next.bind(that), delay);
            }

            this.settings.onTripChange(this.tripIndex, tripObject);
        },

        isFirst : function() {
            return ( this.tripIndex === 0 ) ? true : false;
        },

        isLast : function() {
            return ( this.tripIndex === this.tripData.length - 1 ) ? true : false;
        },

        isTripDataValid : function( o ) {
            // have to check `sel` & `content` two required fields
            if ( typeof o.content === "undefined" ||
                    typeof o.sel === "undefined" ||
                         o.sel === null || o.sel.length === 0 || $(o.sel).length === 0 ) {
                return false;
            }
            return true;        
        },

        hasCallback : function() {
            return (typeof this.tripData[ this.tripIndex ].callback !== "undefined");
        },

        callCallback : function() {
            this.tripData[ this.tripIndex ].callback(this.tripIndex);
        },

        canGoPrev: function() {
            var trip        = this.tripData[ this.tripIndex ],
                canGoPrev   = trip.canGoPrev || this.settings.canGoPrev;

            if ( typeof canGoPrev === "function" ) {
                canGoPrev = canGoPrev.call(trip);
            }

            return canGoPrev;
        },

        canGoNext: function() {
            var trip        = this.tripData[ this.tripIndex ],
                canGoNext   = trip.canGoNext || this.settings.canGoNext;

            if ( typeof canGoNext === "function" ) {
                canGoNext = canGoNext.call(trip);
            }

            return canGoNext;
        },

        increaseIndex : function() {
            if ( this.tripIndex >= this.tripData.length - 1 ) {
                // how about hitting the last item ?
                // do nothing
            }
            else {
                this.tripIndex += 1;
            }
        },

        decreaseIndex : function() {
            if ( this.tripIndex <= 0 ) {
                // how about hitting the first item ?
                // do nothing
            }
            else {
                this.tripIndex -= 1;
            }
        },

        getCurrentTripObject : function() {
            return this.tripData[ this.tripIndex ];
        },

        setTripBlock : function( o ) {
            this.recreateTripBlock();

            var $tripBlock = this.$tripBlock,
                showCloseBox = o.showCloseBox || this.settings.showCloseBox,
                showNavigation = o.showNavigation || this.settings.showNavigation,
                closeBoxLabel = o.closeBoxLabel || this.settings.closeBoxLabel,
                prevLabel = o.prevLabel || this.settings.prevLabel,
                nextLabel = o.nextLabel || this.settings.nextLabel,
                finishLabel = o.finishLabel || this.settings.finishLabel;

            $tripBlock.find('.trip-content')
                      .html( o.content );

            $tripBlock.find('.trip-prev')
                      .html( prevLabel )
                      .toggle( showNavigation && !this.isFirst() );

            $tripBlock.find('.trip-next')
                      .html( this.isLast() ? finishLabel : nextLabel )
                      .toggle( showNavigation );

            $tripBlock.find('.trip-close')
                      .html( closeBoxLabel )
                      .toggle( showCloseBox );

            var $sel = o.sel,
                selWidth = $sel.outerWidth(),
                selHeight = $sel.outerHeight(),
                blockWidth = $tripBlock.outerWidth(),
                blockHeight = $tripBlock.outerHeight(),
                arrowHeight = 10,
                arrowWidth = 10;

            // Take off e/s/w/n classes
            $tripBlock.removeClass('e s w n');

            switch( o.position ) {
            case 'e':
                $tripBlock.addClass('e');
                $tripBlock.css({
                    left : $sel.offset().left + selWidth + arrowWidth,
                    top : $sel.offset().top - (( blockHeight - selHeight ) / 2)
                });
                break;
            case 's':
                $tripBlock.addClass('s');
                $tripBlock.css({
                    left : $sel.offset().left + ((selWidth - blockWidth) / 2),
                    top : $sel.offset().top + selHeight + arrowHeight
                });
                break;
            case 'w':
                $tripBlock.addClass('w');
                $tripBlock.css({
                    left : $sel.offset().left - (arrowWidth + blockWidth),
                    top : $sel.offset().top - (( blockHeight - selHeight ) / 2)
                });
                break;
            case 'n':
            default: 
                $tripBlock.addClass('n');
                $tripBlock.css({
                    left : $sel.offset().left + ((selWidth - blockWidth) / 2),
                    top : $sel.offset().top - arrowHeight - blockHeight
                });

                break;
            }
        },

        showTripBlock : function( o ) {

            this.$tripBlock.css({
                display : 'inline-block',
                zIndex : this.settings.overlayZindex + 1 // we have to make it higher than the overlay
            });

            var windowHeight = $(window).height(),
                windowTop = $(window).scrollTop(),
                tripBlockTop = this.$tripBlock.offset().top,
                OFFSET = 100; // make it look nice

            if ( tripBlockTop < windowTop + windowHeight &&
                    tripBlockTop >= windowTop ) {
                // tripBlock is located inside the current screen, so we don't have to scroll
            }
            else {
                this.$root.animate({ scrollTop : tripBlockTop - OFFSET }, 'slow');
            }
        },

        hideTripBlock : function() {
            this.$tripBlock.fadeOut('slow');
        },

        // TODO:
        // Make sure this method is only called ONCE in this page,
        // so that we will not create same DOMs more than once!
        create : function() {

            if ( !this.$tripBlock ) {
                this.createTripBlock();
                this.createOverlay();
            }
        },

        createTripBlock : function() {

            // make sure the element doesn't exist in the DOM tree
            if ( typeof $('.trip-block').get(0) === 'undefined' ) {

                var html = [
                    '<div class="trip-block">',
                        '<a href="#" class="trip-close"></a>',
                        '<div class="trip-content"></div>',
                        '<div class="trip-progress-wrapper">',
                            '<div class="trip-progress-bar"></div>',
                            '<a href="#" class="trip-prev"></a>',
                            '<a href="#" class="trip-next"></a>',
                        '</div>',
                    '</div>'
                ].join('');

                var $tripBlock = $(html).addClass( this.settings.tripTheme );  

                $('body').append( $tripBlock );

                var that = this;

                $tripBlock.find('.trip-close').click(function(evt) {
                    evt.preventDefault();
                    that.stop();
                });

                $tripBlock.find('.trip-prev').click(function(evt) {
                    evt.preventDefault();
                    that.prev();
                });

                $tripBlock.find('.trip-next').click(function(evt) {
                    evt.preventDefault();
                    that.next();
                });

                this.$tripBlock = $('.trip-block');
                this.$bar = $('.trip-progress-bar');
            }
        },

        recreateTripBlock: function() {
            $('.trip-block').remove();
            this.createTripBlock();
        },

        createOverlay : function() {

            // make sure the element doesn't exist in the DOM tree
            if ( typeof $('.trip-overlay').get(0) === 'undefined' ) {

                var html = [
                    '<div class="trip-overlay">',
                    '</div>'
                ].join('');

                var $overlay = $(html);

                $overlay.height( $(document).height() );

                $('body').append( $overlay );
            }
        },

        init : function() {

            this.preInit();

            if ( this.settings.enableKeyBinding ) {
                this.bindKeyEvents();
            }

            // set refs
            this.$overlay = $('.trip-overlay');
        },

        start : function() {
            // onTripStart callback
            this.settings.onTripStart();

            // create some necessary DOM elements at the first time like jQuery UI
            this.create();

            // init some necessary stuffs like events, late DOM refs after creating DOMs
            this.init();

            // main entry
            this.run();
        }
    };

    // Expose to window
    window.Trip = Trip;


    /*
     *  3rd party libraries / toolkits
     *
     *  1) http://stackoverflow.com/questions/3969475/javascript-pause-settimeout
     */
    function Timer(e,t){var n,r,i=t;this.pause=function(){window.clearTimeout(n);i-=new Date-r};this.resume=function(){r=new Date;n=window.setTimeout(e,i);return i};this.stop=function(){window.clearTimeout(n)};this.resume()}

}(window, jQuery));

$(document).ready(function() {
    var trip = new Trip([
        { 
            sel : $('.step1'), 
            position : 's', 
            content : '<h4>Your Representative</h4>Your local representative<br>contact information includes<br>Twitter, Facebook and Email<br>Find them by Zip Code here.<br>&nbsp\;', 
            delay : 10000,
            callback : function(i) {
                console.log("step "+ i +" is finished");
            }
        }
    ], {
        tripTheme : "black",
        onTripStart : function() {
            console.log("onTripStart");
        },
        onTripEnd : function() {
            console.log("onTripEnd");
        },
        onTripStop : function() {
            console.log("onTripStop");
        },
        onTripChange : function(index, tripBlock) {
            console.log("onTripChange");
        },
        backToTopWhenEnded : true,
        showCloseBox : true,
        delay : 2000
    });
    
    $(".start-home-tour").click(function() {
        trip.start(); 
    });
    
    window.trip = trip;
});

$(document).ready(function() {
    var trip = new Trip([
        { 
            sel : $('.step1'), 
            position : 'w', 
            content : '<h4>We respect privacy</h4>Register and follow issues.<br>&nbsp\;', 
            delay : 5000,
            callback : function(i) {
                console.log("step "+ i +" is finished");
            }
        }
    ], {
        tripTheme : "black",
        onTripStart : function() {
            console.log("onTripStart");
        },
        onTripEnd : function() {
            console.log("onTripEnd");
        },
        onTripStop : function() {
            console.log("onTripStop");
        },
        onTripChange : function(index, tripBlock) {
            console.log("onTripChange");
        },
        backToTopWhenEnded : true,
        showCloseBox : true,
        delay : 2000
    });
    
    $(".start-register-tour").click(function() {
        trip.start(); 
    });
    
    window.trip = trip;
});

$(document).ready(function() {
    var trip = new Trip([
        { 
            sel : $('.step1'), 
            position : 'w', 
            content : '<h4>Current Users</h4>Previously registered users<br>can login and follow issues.<br>&nbsp\;', 
            delay : 5000,
            callback : function(i) {
                console.log("step "+ i +" is finished");
            }
        }
    ], {
        tripTheme : "black",
        onTripStart : function() {
            console.log("onTripStart");
        },
        onTripEnd : function() {
            console.log("onTripEnd");
        },
        onTripStop : function() {
            console.log("onTripStop");
        },
        onTripChange : function(index, tripBlock) {
            console.log("onTripChange");
        },
        backToTopWhenEnded : true,
        showCloseBox : true,
        delay : 2000
    });
    
    $(".start-login-tour").click(function() {
        trip.start(); 
    });
    
    window.trip = trip;
});

$(document).ready(function() {
    var trip = new Trip([
        { 
            sel : $('.step1'), 
            position : 'w', 
            content : '<h4>About HearUs</h4>Freedom of Speech +1.<br>&nbsp\;', 
            delay : 5000,
            callback : function(i) {
                console.log("step "+ i +" is finished");
            }
        }
    ], {
        tripTheme : "black",
        onTripStart : function() {
            console.log("onTripStart");
        },
        onTripEnd : function() {
            console.log("onTripEnd");
        },
        onTripStop : function() {
            console.log("onTripStop");
        },
        onTripChange : function(index, tripBlock) {
            console.log("onTripChange");
        },
        backToTopWhenEnded : true,
        showCloseBox : true,
        delay : 2000
    });
    
    $(".start-about-tour").click(function() {
        trip.start(); 
    });
    
    window.trip = trip;
});

$(document).ready(function() {
    var trip = new Trip([
        { 
            sel : $('.step1'), 
            position : 'w', 
            content : '<h4>Your Results</h4>If your local representative<br> is not a perfect match,<br>search by home address<br>or geo location.<br>&nbsp\;', 
            delay : 5000,
            callback : function(i) {
                console.log("step "+ i +" is finished");
            }
        }
    ], {
        tripTheme : "black",
        onTripStart : function() {
            console.log("onTripStart");
        },
        onTripEnd : function() {
            console.log("onTripEnd");
        },
        onTripStop : function() {
            console.log("onTripStop");
        },
        onTripChange : function(index, tripBlock) {
            console.log("onTripChange");
        },
        backToTopWhenEnded : true,
        showCloseBox : true,
        delay : 2000
    });
    
    $(".start-districts-tour").click(function() {
        trip.start(); 
    });
    
    window.trip = trip;
});

$(document).ready(function() {
    var trip = new Trip([
        { 
            sel : $('.step1'), 
            position : 'e', 
            content : '<h4>Zip Code</h4>We find your local representative<br>by your Zip Code\'s district number.<br>This is often all that is needed.<br>You can provide alternatives for<br>better accuracy including detect-<br>location and home address.', 
            delay : 5000,
            callback : function(i) {
                console.log("step "+ i +" is finished");
            }
        },
        {
            sel : $('.step2'),
            position : 'e',
            content : 'This is a plugin that can help you make hint flow easily !',
            delay : 3000,
            callback : function(i) {
                console.log("step "+ i +" is finished");
            }
        },
        {
            sel : $('.step3'),
            position : 'n',
            content : 'Can be placed in many directions - North',
            delay : 2000
        },
        {
            sel : $('.step4'),
            position : 'e',
            content : 'East',
            delay : 2000
        },
        {
            sel : $('.step5'),
            position : 'w',
            content : 'West',
            delay : 2000
        },
        {
            sel : $('.step6'),
            position : 's',
            content : 'South',
            delay : 2000
        },
        {
            sel : $('.step6'),
            content : 'Can control if the user can proceed',
            delay : 2000,
            canGoNext: function() {
                return confirm("You can only continue if you agree!");
            }
        },
        {
            sel : $('.step6'),
            content : 'You can\'t proceed until you click next',
            delay : -1,
            showNavigation: true
        },
        {
            sel : $('.step7'),
            content : 'The user can stop the tour by hitting Esc or clicking the Close box',
            delay : -1,
            showNavigation: true,
            showCloseBox: true
        },
        {
            sel : $('.step8'),
            position : 'n',
            content : 'One more thing, plz read this !',
            expose : true,
            delay : 7000
        }
    ], {
        tripTheme : "black",
        onTripStart : function() {
            console.log("onTripStart");
        },
        onTripEnd : function() {
            console.log("onTripEnd");
        },
        onTripStop : function() {
            console.log("onTripStop");
        },
        onTripChange : function(index, tripBlock) {
            console.log("onTripChange");
        },
        backToTopWhenEnded : true,
        delay : 2000
    });
    
    $(".start-tour").click(function() {
        trip.start(); 
    });
    
    window.trip = trip;
});
