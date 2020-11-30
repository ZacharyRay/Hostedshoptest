{strip}
{*** Framework CSS ***}
{addLink href='assets/css/libs.css'}

{*** Template CSS ***}
{addLink href='assets/css/template.css'}

{*** Theme CSS ***}
{addLink href='assets/css/barcelona.css'}
{addLink href='assets/css/theme.css'}

{*** Print CSS ***}
{addLink href='assets/css/print.css' media='print'}

{*** Framework Javascript ***}
{addScript src='assets/js/app.js'}
{addScript src='assets/js/barcelona.min.js'}

{collection assign=boxes controller=moduleBox}
{$boxes = $boxes->groupBy('Position')}

{* Define standard class for columns *}
{$columnClass = "col-s-4 col-m-12 col-l-12 col-xl-24"}
{assign var=columns value=0 scope=global}

{* Calculate number of columns needed *}
{if !empty($boxes.left) and !empty($boxes.right)}
    {$columnClass = "col-s-4 col-m-12 col-l-6 col-xl-14"}
    {$columns = 2}
{elseif !empty($boxes.left) or !empty($boxes.right)}
    {$columnClass = "col-s-4 col-m-12 col-l-9 col-xl-19"}
    {$columns = 1}
{/if}

{/strip}<!DOCTYPE html>
<!--[if lt IE 7 ]> <html class="ie6 ielt9 no-js" lang="{$general.languageIso639}"> <![endif]-->
<!--[if IE 7 ]>    <html class="ie7 ielt9 no-js" lang="{$general.languageIso639}"> <![endif]-->
<!--[if IE 8 ]>    <html class="ie8 ielt9 no-js" lang="{$general.languageIso639}"> <![endif]-->
<!--[if IE 9 ]>    <html class="ie9 no-js" lang="{$general.languageIso639}"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html class="no-js" lang="{$general.languageIso639}"> <!--<![endif]-->
<head prefix="og: http://ogp.me/ns#
              fb: http://ogp.me/ns/fb#
              ng: http://angularjs.org">
    {head_include}
</head>
<body id="ng-app" data-ng-app="platform-app" data-ng-strict-di class="site{$general.siteId} language{$general.languageIso} currency{$general.currencyIso} pageId{$page.id} pageCategory{$page.categoryId} pageType{$page.name}" itemscope itemtype="http://schema.org/WebPage">
    <div> heeeej </div>
    {* Language and currency selectors, search, top navigation *}
    {include file='partials/top.tpl'}

    {if !$page.isFrontPage and ($template.settings.SETTINGS_SHOW_BREADCRUMB or $template.settings.SETTINGS_SHOW_PRINT)}
    <div class="container with-xlarge site-wrapper">
        <div class="row">
            <div class="col-s-3 col-m-10 col-l-10 col-xl-20">
                {if $template.settings.SETTINGS_SHOW_BREADCRUMB}
                    {* Breadcrumbs / navigation of the entire site *}
                    {breadcrumbs}
                {/if}
            </div>
            <div class="col-s-1 col-m-2 col-l-2 col-xl-4 text-right">
                {if $template.settings.SETTINGS_SHOW_PRINT}
                    {* Print friendly link *}
                    <div class="m-print">
                        <a title="Printvenlig" onclick="window.print(); return false;" href="#">
                            <i class="fa fa-fw fa-print"></i>
                        </a>
                    </div>
                {/if}
            </div>
        </div>
    </div>
    {/if}

    {* Picture element *}
    <div class="site-slider">
        <div class="container with-xlarge site-wrapper">
            {include file='modules/widgets/slider/page-slider.tpl'}
        </div>
    </div>

    <div class="site-content">

        <div class="container with-xlarge site-wrapper site-main-content">

            {* Notification *}
            {include file="modules/widgets/notification/notification.tpl"}

            <div class="row">
                {if !empty($boxes.left)}
                    {include file='modules/column/column.tpl' boxes=$boxes.left}
                {/if}

                <div class="{$columnClass}">
                    {if $general.isShop and $page.isFrontPage}

                        {*** Frontpage brands ***}
                        {if $template.settings.SHOW_BRAND_SLIDER eq "BRAND_SLIDER"}
                            {include file='modules/widgets/custom/frontpage-brands.tpl'}
                        {/if}

                        {* Featured categories *}
                        {collection assign=categories controller=productCategory parentId=$id pageSize=3}
                        {if $categories and $categories->getActualSize() gt 0}
                            <div class="row">
                                {foreach $categories->getData() as $item}
                                    {include file='modules/product/product-categories-entity.tpl' item=$item}
                                {/foreach}
                            </div>
                        {/if}

                        {* Frontpage focus products *}
                        {collection assign=focusProducts controller=productList focus=frontpage}
                        {if $focusProducts->getActualSize() gt 0}
                            <div class="frontpage-content">
                                <header class="page-title page-title-frontpage">
                                    <span class="h1">{$text.PRODUCT_CATALOG_FOCUS_FRONTPAGE_HEADLINE}</span>
                                </header>

                                <div class="frontpage-products-focus-list">
                                    {include file='modules/product/product-list-combined.tpl' productlist=$focusProducts->filter('Sorting,Title')}
                                </div>
                            </div>
                        {/if}
                    {/if}

                    {* Page content and modules include *}
                    {pageTypeInclude}

                </div>

                {if !empty($boxes.right)}
                    {include file='modules/column/column.tpl' boxes=$boxes.right}
                {/if}
            </div>
        </div>
    </div>

    {if $general.isShop and $page.isFrontPage}
        {if $text.USP_FREE_DELIVERY AND $text.USP_FAST_DELIVERY AND $text.USP_CANCELLATION_TIME}
            {include file='modules/widgets/custom/frontpage-usp.tpl'}
        {/if}
    {/if}

    {* Footer menus, contact data and payment icons *}
    {include file='partials/bottom.tpl'}

    {* General overlays *}
    {if $shop and $shop.priceTerms}
        {include file='modules/widgets/overlay/overlay.tpl' dataId='priceTerms' dataItemId=$shop.priceTerms.id}
    {/if}
    {* Cookie consent *}
    {include file="modules/widgets/cookie/cookie.tpl"}
    {body_include}

</body>
</html>
