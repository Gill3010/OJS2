{**
 * templates/frontend/pages/about.tpl
 *
 * Copyright (c) 2014-2024 Simon Fraser University
 * Copyright (c) 2003-2024 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Display the page to view information about a journal.
 *
 * @uses $currentContext Journal|Press The current journal or press
 *}
{include file="frontend/components/header.tpl" pageTitle="about.aboutContext"}

<div id="main-content" class="page page_about">

	{include file="frontend/components/breadcrumbs.tpl" currentTitleKey="about.aboutContext"}

	{* Page Title *}
	<div class="page-header">
		<h1>{translate key="about.aboutContext"}</h1>
	</div>
	{* /Page Title *}

	{$currentContext->getLocalizedData('about')}
</div><!-- .page -->

{include file="common/frontend/footer.tpl"}
