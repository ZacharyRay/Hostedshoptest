$(function(){
    
    // Hamburger menu
    $('.menu-open-button').on('click', function(){
       $('.hamburger-menu').addClass('show-menu');
    });
    $('.menu-action-header, .pagedim').on('click', function(){
        $('.hamburger-menu').removeClass('show-menu');
    });
    
    // Mobile search
    $('.mobile-search-button').on('click', function(e){
        if(e.handled !== true) // This will prevent event triggering more then once
        {
            e.handled = true;
            
            $('.search-wrapper').toggle();
        }
    });
    
    // Mobile product category menu
    var productNav = $('#clonedMenu').clone();
    $('#menuReplace').html(productNav);
    
    $('#menuReplace .parent-category .menu-dropdown-toggle').on('click', function(e){
        e.preventDefault();
        
        if(e.handled !== true) // This will prevent event triggering more then once
        {
            e.handled = true;
            
            $(this).children('i').toggleClass('fa-caret-down').toggleClass('fa-caret-up');
            $(this).parent().siblings('.dropdown-megamenu').toggleClass('visible'); 
        }
    });
    
    // Product badges
    if($('.m-productlist')){
            
        setInterval(function(){
            $('.m-productlist-splash-sale, .type-col .m-productlist-sale').each( function(){
                var fullPrice = parseInt($(this).data('fullprice'));
                
                var discountPrice = $(this).data('discountprice');
                discountPrice = discountPrice.replace(/\./g,'');
                discountPrice = discountPrice.replace(/(\,\d+)+/,'');
                discountPrice = discountPrice.replace(/^(.*?)stk/,'');
                discountPrice = discountPrice.replace(/[^0-9]+/g,'');
                discountPrice = parseInt(discountPrice);

                var percentage = (fullPrice - discountPrice) / fullPrice * 100;
                var pctToSave = '-' + percentage.toFixed(0) + '%';

                $(this).text(pctToSave);
            });
        }, 500);
            
    }
    if($('.m-product-price-before-discount')){
        var badgeToReplace = $('.m-product-splash-sale');
            
        var discountPrice = parseFloat($('.m-product-price').text().replace(/\./g,''));
        var fullPrice = parseFloat($('.m-product-price-before-discount').text().replace(/\./g,''));
            
        var percentage = (fullPrice - discountPrice) / fullPrice * 100;
        var pctToSave = '-' + percentage.toFixed(0) + '%';

        $('.m-product-splash-sale').text(pctToSave);
    }
    
    // Modal close
    if($('.w-notification')){

        function removeSystemModal(e){
            if(e.target !== e.currentTarget) return;

            $('.w-notification').hide();
        }

        $('.w-notification').on('click', removeSystemModal);

        $('.w-notification .panel .modal-close-button').on('click', function(){
            $('.w-notification').hide();
        });
    }
    
    // Checkout page - customer type
    var deliveryTypeSelect = $('#customer-type-select');

    var deliveryCompany = $('.m-checkout-company');
    var deliveryVATNo = $('.m-checkout-vatnumber');
    var deliveryEAN = $('.m-checkout-eannumber');

    deliveryCompany.hide();
    deliveryVATNo.hide();
    deliveryEAN.hide();

    deliveryTypeSelect.on('change', function(e){
        if($(this).val() == "virksomhed"){
            deliveryCompany.show();
            deliveryVATNo.show();
            deliveryEAN.hide();
        }else if($(this).val() == "offentlig"){
            deliveryCompany.show();
            deliveryVATNo.show();
            deliveryEAN.show();
        }else {
            deliveryCompany.hide();
            deliveryVATNo.hide();
            deliveryEAN.hide();
        }
    });
    
    // USP owl slider
    $('.global_usp > ul').owlCarousel({
        loop:true,
        autoPlay: 3000,
        pagination:false,
        navigation:true,
        navigationText: ["<i class='fa fa-chevron-left'></i>","<i class='fa fa-chevron-right'></i>"],
        items:3,
        itemsDesktop: [1199, 3],
        itemsDesktopSmall: [980, 2],
        itemsTablet: [768, 1],
        itemsMobile: [479, 1]
    });
    
    // Footer brand toggle
    var brandsNum = $('.footer-brands li').length;
    $('.brands-toggle').hide();
    
    if(brandsNum > 10){
        $('.footer-brands').addClass('hideExcess');
        $('.brands-toggle').show();
    }
    
    $('.brands-toggle').on('click', function(){
       $('.footer-brands').toggleClass('hideExcess'); 
    });
    
    // Frontpage brand slider
    if($('#frontpage-brands-products').length){
        $('#frontpage-brands-products').owlCarousel({
            loop:true,
            autoPlay: 3000,
            pagination:false,
            navigation:true,
            navigationText: ["<i class='fa fa-chevron-left'></i>","<i class='fa fa-chevron-right'></i>"],
            items:6,
            itemsDesktop: [1199, 6],
            itemsDesktopSmall: [980, 4],
            itemsTablet: [768, 3],
            itemsMobile: [520, 2]
        });
    }

    // test alert
    console.log('helloooo it workss');
    alert('yoo it works');
    
});