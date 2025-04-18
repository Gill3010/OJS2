{**
 * templates/frontend/pages/indexSite.tpl
 *
 * Copyright (c) 2014-2024 Simon Fraser University
 * Copyright (c) 2003-2024 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * Site index.
 *}
{include file="frontend/components/header.tpl"}

<div id="main-site" class="page_index_site">

	{if $about}
		<div class="about_site">
			{$about|nl2br}
		</div>
	{/if}

	<div class="journals">
		<div class="page-header">
			<h2>
				{translate key="context.contexts"}
			</h2>
		</div>

		{if !count($journals)}
			<div class="no_journals">
				{translate key="site.noJournals"}
			</div>

		{else}
			<ul class="media-list">
				{foreach from=$journals item=journal}
					{capture assign="url"}{url journal=$journal->getPath()}{/capture}
					{assign var="thumb" value=$journal->getLocalizedData('journalThumbnail')}
					{assign var="description" value=$journal->getLocalizedDescription()}
					<li class="media">
						{if $thumb}
							<div class="media-left">
								<a href="{$url|escape}">
									<img class="media-object" src="{$journalFilesPath}{$journal->getId()}/{$thumb.uploadName|escape:"url"}"{if $thumb.altText} alt="{$thumb.altText|escape}"{/if}>
								</a>
							</div>
						{/if}

						<div class="media-body">
							<h3 class="media-heading">
								<a href="{$url|escape}" rel="bookmark">
									{$journal->getLocalizedName()}
								</a>
							</h3>
							{if $description}
								<div class="description">
									{$description|nl2br}
								</div>
							{/if}
							<ul class="nav nav-pills">
								<li class="view">
									<a href="{$url|escape}">
										{translate key="site.journalView"}
									</a>
								</li>
								<li class="current">
									<a href="{url|escape journal=$journal->getPath() page="issue" op="current"}">
										{translate key="site.journalCurrent"}
									</a>
								</li>
							</ul>
						</div>
					</li>
				{/foreach}
			</ul>
		{/if}
	</div>

</div><!-- .page -->

{include file="frontend/components/footer.tpl"}

{* Incluir tu archivo CSS personalizado *}
<link rel="stylesheet" href="{$base_url}/plugins/themes/bootstrap3/assets/css/styles.css">

{* Incluir tu archivo JS personalizado *}
<script src="{$base_url}/plugins/themes/bootstrap3/assets/js/scripts.js"></script>
