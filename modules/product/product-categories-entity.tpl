{*

# Description
Template for a category. Part of the Product page type.


## Date last modified
2020-02-14

Modifications:
- Line 34: Changed col classes in order to display three columns instead of four at M breakpoint
- Line 42: Removed 293 width and height from thumbnail image, allowing it to grow to full width
- Line 46: Removed .placeholder-wrapper class
- Line 56: Adding the $text.SHOP_NOW variable to the header


## Primary variables
+ $item 													- Entity of productCategoryController (a single shop product category)
+ $pagelink 												- Link / URL to the product page


## Partials (templates)
No extra templates required for this template

*}

{* Placeholder image *}
{placeholdImage assign=placeholder width=293 height=293 background=$template.settings.DESIGN_IMAGE_BACKGROUND_COLOR color=$template.settings.FONT_COLOR_PRIMARY text=$text.IMAGE_PLACEHOLDER_TEXT}

{$crop = "fill"}
{if !empty($template.settings.DESIGN_IMAGE_BACKGROUND_COLOR)}
    {$crop = $template.settings.DESIGN_IMAGE_BACKGROUND_COLOR}
{/if}
{$pagelink = {page id=$page.productPageId print=Link}}
<div class="col-s-2 col-m-4 col-l-4 col-xl-6 category-item">
    {* Category *}
    <article class="category-item-content">
	{* Category picture *}
	<figure class="category-item-image">
            {entity assign=image controller=files type=category id=$item->Id}
            {if $image}
		{$imgpath = $image->thumbnail(null, null, $crop)|solutionPath}
            {else}
		{$imgpath = $placeholder->getRelativeFile()|solutionPath}
            {/if}
            <a class="trailing-db" href="/{$pagelink}/{$item->Handle}/" title="{$item->Title}">
                <span class="placeholder"></span>
                {img class="responsive" alt="{$item->Title}" src="{$imgpath}"}
            </a>
	</figure>
    
	{* Category title *}
	<header class="category-item-title">
            <a href="/{$pagelink}/{$item->Handle}/" title="{$item->Title}">
                <h4 class="h5">{$item->Title}</h4>
                <p>{$text.SHOP_NOW}</p>
            </a>
	</header>
    </article>
</div>
