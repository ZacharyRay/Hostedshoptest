{$productLink = {page id=$page.productPageId print=Link}}

{* Fetch brands *}
{collection controller=brand assign=brands}

{if $brands->getActualSize() gt 0}
    <div class="frontpage-brands">
        <div id="frontpage-brands-products">

            {foreach $brands->getData() as $brand}
                {entity assign=brandImage controller=files type=brand id=$brand->Id}
                {if $brandImage}
                    <a href="/{$productLink}/?brand={$brand->Id}-{$brand->Title|formatLink}">
                        {img class="m-product-brand-icon m-product-brand-logo" style="vertical-align:middle;margin:0;" itemprop="logo" src="{$brandImage->thumbnail()|solutionPath}" alt="{$brand->Title}"}   
                    </a>
                {else}
                    <a href="/{$productLink}/?brand={$brand->Id}-{$brand->Title|formatLink}">{$brand->Title}</a>
                {/if}
            {/foreach}
        </div>
    </div>
{/if}