{* Fetch products link *}
{$productLink = {page id=$page.productPageId print=Link}}

<footer class="site-footer"  itemscope itemtype="http://schema.org/WPFooter">
	<div class="container with-xlarge trailing-trip">
		<div class="row">
			<div class="col-s-4 col-m-6 col-l-3 col-xl-6">
                            <h4>
                                {$text.CONTACT_TEXT}
                            </h4>
				<ul class="contact-data-container">
					{if $contactdata.name && $template.settings.SETTINGS_SHOW_CONTACT_TITLE}
						<li class="contact-data-name contact-data-list"><span>{$contactdata.name}</span></li>
					{/if}
					{if $contactdata.address && $template.settings.SETTINGS_SHOW_CONTACT_ADDRESS}
						<li class="contact-data-address contact-data-list"><span>{$contactdata.address}</span></li>
					{/if}
					{if ($contactdata.zipcode && $template.settings.SETTINGS_SHOW_CONTACT_ZIPCODE) || ($contactdata.city && $template.settings.SETTINGS_SHOW_CONTACT_CITY)}
						<li class="contact-data-address contact-data-list"><span>
							{if $contactdata.zipcode && $template.settings.SETTINGS_SHOW_CONTACT_ZIPCODE}
								{$contactdata.zipcode}
							{/if}
							{if $contactdata.city && $template.settings.SETTINGS_SHOW_CONTACT_CITY}
								{$contactdata.city}
							{/if}
						</span></li>
					{/if}
					{if $contactdata.country && $template.settings.SETTINGS_SHOW_CONTACT_COUNTRY}
						<li class="contact-data-country contact-data-list"><span>{$contactdata.country}</span></li>
					{/if}
                                        {if $contactdata.vatnumber && $template.settings.SETTINGS_SHOW_CONTACT_VAT_NUMBER}
						<li class="contact-data-vat contact-data-list"><span><span class="contact-text">{$text.VAT_NR}</span><span class="contact-colon">:</span> {$contactdata.vatnumber}</span></li>
					{/if}
					{if $contactdata.bankinfo && $template.settings.SETTINGS_SHOW_CONTACT_BANK_NUMBER}
						<li class="contact-data-bank contact-data-list"><span><span class="contact-text">{$text.BANK_DETAILS}</span><span class="contact-colon">:</span> {$contactdata.bankinfo}</span></li>
					{/if}
                                        
					{if $contactdata.phone && $template.settings.SETTINGS_SHOW_CONTACT_PHONE}
                                            <li class="contact-data-telephone contact-data-list"><br><span><span class="contact-text">{$text.TELEPHONE}</span><span class="contact-colon">:</span> {$contactdata.phone}</span></li>
					{/if}
					{if $contactdata.mobilephone && $template.settings.SETTINGS_SHOW_CONTACT_MOBILE}
						<li class="contact-data-mobile contact-data-list"><span><span class="contact-text">{$text.MOBILE}</span><span class="contact-colon">:</span> {$contactdata.mobilephone}</span></li>
					{/if}
					{if $contactdata.fax && $template.settings.SETTINGS_SHOW_CONTACT_FAX}
						<li class="contact-data-fax contact-data-list"><span><span class="contact-text">{$text.FAX}</span><span class="contact-colon">:</span> {$contactdata.fax}</span></li>
					{/if}
					{if $contactdata.email && $template.settings.SETTINGS_SHOW_CONTACT_EMAIL}
						<li class="contact-data-email contact-data-list">
							<span class="contact-text">{$text.MAIL}</span><span class="contact-colon">:</span>
							{if $settings.spam_email_block}
								{$email = $contactdata.email|replace:'@':'---'}
								{placeholdImage assign=placeholder text=$email color=$template.settings.FONT_COLOR_PRIMARY atreplace='---' transparent=true size=10}
							   	<a href="/obfuscated/" onclick="var m = '{$email}'; this.href = 'mailto:' + m.replace('---', '@'); return true;">
							   		<span>
							      		{img style="margin:0; vertical-align: middle;" alt="" src="{$placeholder->getRelativeFile()}"}
							      </span>
							   	</a>
							{else}
							   	<a href="mailto:{$contactdata.email}">{$contactdata.email}</a>
							{/if}
						</li>
					{/if}
					
					{if $template.settings.SETTINGS_SHOW_SITEMAP}
                                            <li class="contact-data-site-map contact-data-list"><br><a href="/{$text.SITEMAP_LINK}/">{$text.SITEMAP_HEADLINE}</a></li>
					{/if}
				</ul>
                                

                                {$socialFooter =  !empty($settings.social_instagram_pageurl) ||
                                                                                                        $settings.social_facebook and !empty($settings.social_plugin_likebox_pageurl) ||
                                                                                                        $settings.social_twitter  and !empty($settings.social_twitter_pageurl) ||
                                                                                                        $settings.social_google   and !empty($settings.social_google_pageurl)
                                }

                                {if $access.social and $socialFooter}
                                        <div class="col-s-4 col-m-12 col-l-12 col-xl-24 social-links">
                                                {if $settings.social_plugin_likebox_pageurl and $settings.social_facebook}
                                                        <a class="social-link social-facebook" href="{$settings.social_plugin_likebox_pageurl}" title="{$text.SOCIAL_BOX_FACEBOOK}" target="_blank"><i class="fa fa-facebook-square"></i></a>
                                                {/if}
                                                {if $settings.social_twitter_pageurl and $settings.social_twitter}
                                                        <a class="social-link social-twitter" href="{$settings.social_twitter_pageurl}" title="{$text.SOCIAL_BOX_TWITTER}" target="_blank"><i class="fa fa-twitter-square"></i></a>
                                                {/if}
                                                {if $settings.social_google_pageurl and $settings.social_google}
                                                        <a class="social-link social-google" href="{$settings.social_google_pageurl}" title="{$text.SOCIAL_BOX_GOOGLE}" target="_blank"><i class="fa fa-google-plus-square"></i></a>
                                                {/if}
                                                {if $settings.social_instagram_pageurl}
                                                        <a class="social-link social-instagram" href="{$settings.social_instagram_pageurl}" title="{$text.SOCIAL_BOX_INSTAGRAM}" target="_blank"><i class="fa fa-instagram"></i></a>
                                                {/if}
                                        </div>
                                {/if}
                        </div>
                        
                        {$brandsShown = $template.settings.MODULEBOX_PRODUCT_CATEGORIES_SHOW_BRAND}
                        {if $brandsShown}
                                
                            <div class="col-s-4 col-m-6 col-l-3 col-xl-6 footer-brands">
                                <h4>
                                    {$text.PRODUCT_CATALOG_BRANDS}
                                </h4>

                                {* Fetch brands *}
                                {collection controller=brand assign=brands}

                                {if $brands->getActualSize() gt 0}
                                    <ul>
                                            {foreach $brands->getData() as $brand}
                                                <li>
                                                <a href="/{$productLink}/?brand={$brand->Id}-{$brand->Title|formatLink}">{$brand->Title}</a>
                                                </li>
                                            {/foreach}
                                    </ul>
                                {/if}
                                
                                <div class="brands-toggle">
                                    {$text.SEE_MORE}
                                </div>
                            </div>
                        {/if}
                        <div class="col-s-4 col-m-6 col-l-3 col-xl-6 footer-information">
                            <h4>
                                {$text.SWITCH_INFORMATION}
                            </h4>
                            {menu static=false assign=textmenu categoryId=3}

                            {include
                                file='modules/widgets/menu/menu.tpl'
                                items=$textmenu
                                classes=''
                            }
                        </div>
                        <div class="col-s-4 col-m-6 col-l-3 col-xl-6">
                            {if $settings.news_signup}
                            {include file='modules/widgets/newsletter/newsletter.tpl'}
                            {/if}
                        </div>
                </div>
        </div>

	<!-- paymenticons -->
	{if $general.isShop && $template.settings.SETTINGS_SHOW_CART_ICONS_FOOTER}
		<div class="text-center footer-paymenticons">
			{if $template.settings.SETTINGS_SHOW_BIG_CART_ICONS_FOOTER}
				{$imageWidth  = 54}
				{$imageHeight = 30}
				{paymentIcons assign=icons iconSize=large}
			{else}
				{$imageWidth  = 34}
				{$imageHeight = 24}
				{paymentIcons assign=icons}
			{/if}
			{$imageAspect = "{($imageHeight / $imageWidth) * 100}%"}
			{if $icons->getActualSize() gt 0}
				<ul class="payment-icons list-unstyled">
					{foreach $icons->getData() as $icon}
						<li class="payments-icon payments-icon-{$icon@index} is-inline-block placeholder-wrapper" data-placeholder-max-width="{$imageWidth}px">
							<span class="placeholder" data-placeholder-aspect="{$imageAspect}"></span>
							{img alt="{$icon->Title}" title="{$icon->Title}" src="{$template.cdn}{$icon->RelativeFile}"}
						</li>
					{/foreach}
				</ul>
			{/if}
		</div>
	{/if}

</footer>
