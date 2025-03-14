<?php
/* Smarty version 4.3.1, created on 2025-03-14 15:53:36
  from 'plugins-9-plugins-blocks-keywordCloud-blocks-keywordCloud:block.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '4.3.1',
  'unifunc' => 'content_67d4510037f546_95699550',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '69ff47b9b9f9266feaf910e554f127d2e3b68631' => 
    array (
      0 => 'plugins-9-plugins-blocks-keywordCloud-blocks-keywordCloud:block.tpl',
      1 => 1741879308,
      2 => 'plugins-9-plugins-blocks-keywordCloud-blocks-keywordCloud',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_67d4510037f546_95699550 (Smarty_Internal_Template $_smarty_tpl) {
?>
<div class="pkp_block block_keyword_cloud">
    <h2 class="title"><?php echo call_user_func_array( $_smarty_tpl->smarty->registered_plugins[Smarty::PLUGIN_FUNCTION]['translate'][0], array( array('key'=>"plugins.block.keywordCloud.title"),$_smarty_tpl ) );?>
</h2>
    <div class="content" id='wordcloud'></div>

    <?php echo '<script'; ?>
>
        function randomColor() {
            var cores = ['#1f77b4', '#ff7f0e', '#2ca02c', '#d62728', '#9467bd', '#8c564b', '#e377c2', '#7f7f7f', '#bcbd22', '#17becf'];
            return cores[Math.floor(Math.random()*cores.length)];
        }

        <?php if ($_smarty_tpl->tpl_vars['keywords']->value) {?>
            document.addEventListener("DOMContentLoaded", function() {
                var keywords = <?php echo $_smarty_tpl->tpl_vars['keywords']->value;?>
;
                var totalWeight = 0;
                var blockWidth = 300;
                var blockHeight = 200;
                var transitionDuration = 200;
                var length_keywords = keywords.length;
                var layout = d3.layout.cloud();

                layout.size([blockWidth, blockHeight])
                    .words(keywords)
                    .fontSize(function(d)
                    {
                        return fontSize(+d.size);
                    })
                    .on('end', draw);

                var svg = d3.select("#wordcloud").append("svg")
                    .attr("viewBox", "0 0 " + blockWidth + " " + blockHeight)
                    .attr("width", '100%');

                function update() {
                    var words = layout.words();
                    fontSize = d3.scaleLinear().range([16, 34]);
                    if (words.length) {
                        fontSize.domain([+words[words.length - 1].size || 1, +words[0].size]);
                    }
                }

                keywords.forEach(function(item,index){totalWeight += item.size;});

                update();

                function draw(words, bounds) {
                    var width = layout.size()[0],
                        height = layout.size()[1];

                    scaling = bounds
                        ? Math.min(
                            width / Math.abs(bounds[1].x - width / 2),
                            width / Math.abs(bounds[0].x - width / 2),
                            height / Math.abs(bounds[1].y - height / 2),
                            height / Math.abs(bounds[0].y - height / 2),
                        ) / 2
                        : 1;

                    svg
                    .append("g")
                    .attr(
                        "transform",
                        "translate(" + [width >> 1, height >> 1] + ")scale(" + scaling + ")",
                    )
                    .selectAll("text")
                        .data(words)
                    .enter().append("text")
                        .style("font-size", function(d) { return d.size + "px"; })
                        .style("font-family", 'serif')
                        .style("fill", randomColor)
                        .style('cursor', 'pointer')
                        .style('opacity', 0.7)
                        .attr('class', 'keyword')
                        .attr("text-anchor", "middle")
                        .attr("transform", function(d) {
                            return "translate(" + [d.x, d.y] + ")rotate(" + d.rotate + ")";
                        })
                        .text(function(d) { return d.text; })
                        .on("click", function(d, i){
                            window.location = "<?php echo call_user_func_array( $_smarty_tpl->smarty->registered_plugins[Smarty::PLUGIN_FUNCTION]['url'][0], array( array('router'=>(defined('ROUTE_PAGE') ? constant('ROUTE_PAGE') : null),'page'=>"search",'query'=>"QUERY_SLUG"),$_smarty_tpl ) );?>
".replace(/QUERY_SLUG/, encodeURIComponent(''+d.text+''));
                        })
                        .on("mouseover", function(d, i) {
                            d3.select(this).transition()
                                .duration(transitionDuration)
                                .style('font-size',function(d) { return (d.size + 3) + "px"; })
                                .style('opacity', 1);
                        })
                        .on("mouseout", function(d, i) {
                            d3.select(this).transition()
                                .duration(transitionDuration)
                                .style('font-size',function(d) { return d.size + "px"; })
                                .style('opacity', 0.7);
                        })
                        .on('resize', function() { update() });
                }

                layout.start();
            });
        <?php }?>
	<?php echo '</script'; ?>
>
</div>
<?php }
}
