{includeScript file='partials/body.js.tpl'}

{*** Languages collection ***}
{collection controller=language assign=languages}

{*** Get all shop currencies ***}
{collection controller=currency assign=currencies}

{* USP bar *}
{include file='modules/widgets/custom/usp.tpl'}

{* Header *}
<header class="site-header" itemscope itemtype="http://schema.org/WPHeader">
    <div class="container with-xlarge">
        <div class="row">
            <div class="col-s-4 col-m-12 col-l-4 col-xl-8 search-wrapper">
                {if $template.settings.SETTINGS_SHOW_SEARCH}
                    <div class="search-module">
                        <form class="top-search-form" method="get" action="/{if $general.isShop}{page id=$page.productPageId print=Link}{else}{$Text.SEARCH_LINK}{/if}/">
                            <label for="search" class="input-group xsmall">
                                <span class="input-group-button"><button class="button" type="submit"><i class="fa fa-search"></i></button></span>
                                <input type="text" class="form-input input-group-main" placeholder="{$Text.SEARCH_TEXT}" name="search" required>
                            </label>
                        </form>
                    </div>
                {/if}
            </div>
            <div class="col-s-4 col-m-12 col-l-4 col-xl-8">
                {include file='modules/widgets/logo/logo.tpl'}
            </div>
            <div class="col-s-4 col-m-12 col-l-4 col-xl-8">
                <div class="desktop-icon-nav">
                    <span class="header-icon-button mobile-search-button">
                        <i class="fa fa-search"></i>
                    </span>
                    {if $general.isShop && $template.settings.SETTINGS_SHOW_CART && $page.type != 'cart' && $page.type != 'checkout'}
                        {* Cart controller *}
                        {collection controller=cart assign=cart}
                        {$cartList = $cart->groupByClass()}
                        
                        <span class="header-icon-button">
                        {include file='modules/widgets/cart/cart.tpl' cart=$cart}
                        
                            <a href="/{$text.CART_LINK}/" class="mobile-cart-link">
                                <i class="fa fa-shopping-cart"><span class="m-quick-cart__count h6">{$cart->getActualSize()}</span></i>
                            </a>
                        </span>
                    {else}
                        {* Cart controller *}
                        {collection controller=cart assign=cart}
                        {$cartList = $cart->groupByClass()}
                        
                        <span class="header-icon-button">
                            <a href="/{$text.CART_LINK}/" class="cart-link-alt">
                                <i class="fa fa-shopping-cart"><span class="m-quick-cart__count h6">{$cart->getActualSize()}</span></i>
                            </a>
                        </span>
                    {/if}

                    {if $template.settings.SETTINGS_SHOW_MY_ACCOUNT}
                        <span class="header-icon-button header-user-button">
                            {if $user}
                                <a href="/{$text.USER_UPDATE_LINK}/">
                                    <i class="fa fa-user"></i>
                                </a>
                            {else}
                                <a href="/{$text.LOGIN_LINK}/">
                                    <i class="fa fa-user"></i>
                                </a>
                            {/if}
                        </span>
                    {/if}
                    <span class="menu-open-button header-icon-button">
                        <a href="">
                            <i class="fa fa-bars"></i>
                        </a>
                    </span>
                </div>
            </div>
        </div>
    </div>
</header>
                    
{* Category navigation *}
<div class="site-navigation">
    <nav class="navbar w-widget widget" itemscope itemtype="http://schema.org/SiteNavigationElement">

        {* Fetch product categories *}
        {controller type=productCategory assign=controller primary=true}
        {collection controller=productCategory assign=categories}

        {* Fetch products link *}
        {$productLink = {page id=$page.productPageId print=Link}}

        {if $categories->getActualSize() gt 0}
            <div class="main-menu">
                <div class="container">
                    <ul id="clonedMenu" class="productcategories-level-0">
                        {foreach $categories->getData() as $category}
                            
                            {* Fetch product categories level 1 *}
                            {collection controller=productCategory assign=categories1 parentId=$category->Id}
                                
                            <li class="b-productcategory b-category-li-0 b-category-{$category->Id}{if $category->IsActive} active{/if} {if $categories1->getActualSize() gt 0}parent-category{/if}">
                                <a class="b-productcategory-anchor b-anchor" href="/{$productLink}/{$category->Handle}/">
                                    {$category->Title}
                                    
                                    {if $categories1->getActualSize() gt 0}
                                        <span class="menu-dropdown-toggle">
                                            <i class="fa fa-caret-down"></i>
                                        </span>
                                    {/if}
                                </a>

                                {if $categories1->getActualSize() gt 0}
                                    <div class="dropdown-megamenu">
                                        <ul class="b-productcategories-list b-productcategories-level-1">
                                            {foreach $categories1->getData() as $category1}
                                                <li class="b-productcategory b-category-li-1 b-category-{$category1->Id}{if $category1->IsActive} active{/if}">
                                                    <a href="/{$productLink}/{$category1->Handle}/">{$category1->Title}</a>

                                                    {* Fetch product categories level 2 *}
                                                    {collection controller=productCategory assign=categories2 parentId=$category1->Id}
                                                    {if $categories2->getActualSize() gt 0}
                                                        <ul class="b-productcategories-list b-productcategories-level-2">
                                                            {foreach $categories2->getData() as $category2}
                                                                <li class="b-productcategory b-category-li-2 b-category-{$category2->Id}{if $category2->IsActive} active{/if}">
                                                                    <a href="/{$productLink}/{$category2->Handle}/">{$category2->Title}</a>
                                                                </li>
                                                            {/foreach}
                                                        </ul>
                                                    {/if}
                                                </li>
                                            {/foreach}
                                        </ul>
                                    </div>
                                {/if}
                            </li>
                        {/foreach}
                    </ul>
                </div>
            </div>
        {/if}
                    
    </nav>
</div>

{* Mobile / Hamburger menu *}
<div class="hamburger-menu">
    
    <nav class="menu-inner-wrapper">
        <header class="menu-header menu-action-header">
            <h6>{$text.MENU_CLOSE}</h6>
            <span class="menu-close-button"><i class="fa fa-times"></i></span>
        </header>
        <div id="menuReplace"></div>
        {$static = false}
        {if $template.settings.SETTINGS_SHOW_MY_ACCOUNT}
            {$static = true}
        {/if}

        {menu assign=primaryMenu static=$static}

        {include
            file='modules/widgets/menu/menu.tpl'
            items=$primaryMenu
            classes='sidebarMenu'
        }
        
        {* Language and currency dropdowns *}
        {if $languages->getActualSize() gt 1 || $currencies and $currencies->getActualSize() gt 1}
            <br>
            <div class="menu-header">
                <h6>{$text.LANG_AND_CURRENCY}</h6>
            </div>
            <div class="settings-dropdowns dropdown-pickers">

                {if $languages->getActualSize() gt 1}
                    <div class="w-language-picker is-inline-block">
                        {$showFlag = true}
                        {$showText = true}
                        {if $template.settings.SETTINGS_TYPE_LANGUAGE eq 'FLAG'}
                            {$showText = false}
                        {elseif $template.settings.SETTINGS_TYPE_LANGUAGE eq 'TEXT'}
                            {$showFlag = false}
                        {/if}

                        {include file="modules/widgets/language/language.tpl" collection=$languages type="dropdown" showFlag=$showFlag showText=$showText}
                    </div>
                {/if}

                {if $currencies and $currencies->getActualSize() gt 1}
                    <div class="w-currency-picker is-inline-block">
                        {include file="modules/widgets/currency/currency.tpl" collection=$currencies type="dropdown"}
                    </div>
                {/if}

            </div>

        {/if}
    </nav>
</div>
<div class="pagedim"></div>
