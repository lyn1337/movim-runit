{if="$info != null && $info->pubsubpublishmodel != null && $info->pubsubpublishmodel != 'publishers'"}
    {if="$info->pubsubpublishmodel == 'open' || ($info->pubsubpublishmodel == 'subscribers' && $subscription != null)"}
        <a class="button action color" title="{$c->__('menu.add_post')}" href="{$c->route('publish', [$server, $node])}">
            <i class="material-symbols">{if="$info->isGallery()"}add_photo_alternate{else}post_add{/if}</i>
        </a>
    {/if}
{else}
    <a onclick="CommunityHeader_ajaxTestPublish('{$server}', '{$node}')" class="button action color" title="{$c->__('menu.add_post')}">
        <i class="material-symbols">{if="$info!= null && $info->isGallery()"}add_photo_alternate{else}post_add{/if}</i>
    </a>
{/if}
<ul class="list thick">
    <li>
        <span class="primary icon active gray" onclick="history.back()">
            <i class="material-symbols">arrow_back</i>
        </span>
        {if="$info != null"}
            <span class="primary icon bubble active"
                    onclick="MovimUtils.reload('{$c->route('community', [$server, $info->node])}')">
                <img src="{$info->getPicture('l')}"/>
            </span>
        {/if}
        <div>
            {if="$c->getUser()->hasPubsub()"}
                {if="$subscription == null"}
                    <button class="button oppose color green" title="{$c->__('communityheader.subscribe')}"
                    onclick="CommunityHeader_ajaxAskSubscribe('{$server|echapJS}', '{$node|echapJS}')">
                    <i class="material-symbols">bookmark_add</i> <span class="on_desktop">{$c->__('communityheader.subscribe')}</span>
                    </button>
                {else}
                    <button class="button oppose color gray" title="{$c->__('communityheader.unsubscribe')}"
                    onclick="CommunityHeader_ajaxAskUnsubscribe('{$server|echapJS}', '{$node|echapJS}')">
                        <i class="material-symbols">bookmark_remove</i> <span class="on_desktop">{$c->__('communityheader.unsubscribe')}</span>
                    </button>
                {/if}
            {/if}
            <p class="line">
                {if="$info != null"}
                    {if="$info->name"}
                        {$info->name}
                    {else}
                        {$info->node}
                    {/if}
                {else}
                    {$node}
                {/if}
            </p>
            <p class="line on_mobile" {if="$info != null && $info->description"}title="{$info->description|strip_tags}"{/if}>
                {if="$num > 0"}
                    <i class="material-symbols">article</i> {$num}
                {/if}
                {if="$info != null"}
                    · <i class="material-symbols">people</i> {$info->occupants}
                    {if="$info->description"}
                        · {$info->description|strip_tags}
                    {/if}
                {else}
                    {$server}
                {/if}
            </p>
            <p class="line on_desktop">
                <a href="{$c->route('community', [$server])}">
                    {$server}
                </a>
            </p>
        </div>
    </li>
</ul>
