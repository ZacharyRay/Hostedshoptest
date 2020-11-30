{* Frontpage USP *}
        <div class="frontpage_usp">
            <div class="container width-xlarge">
                <ul>
                    {if $text.USP_FREE_DELIVERY}
                        <li>
                            <i class="fa fa-truck"></i>
                            <p>{$text.USP_FREE_DELIVERY}</p>
                            {if $text.USP_FREE_DELIVERY_2}
                                <p class="usp_subtext">{$text.USP_FREE_DELIVERY_2}</p>
                            {/if}
                        </li>
                    {/if}
                    {if $text.USP_FAST_DELIVERY}
                        <li>
                            <i class="fa fa-clock-o"></i>
                            <p>{$text.USP_FAST_DELIVERY}</p>
                            {if $text.USP_FAST_DELIVERY_2}
                                <p class="usp_subtext">{$text.USP_FAST_DELIVERY_2}</p>
                            {/if}
                        </li>
                    {/if}
                    {if $text.USP_CANCELLATION_TIME}
                        <li>
                            <i class="fa fa-check"></i>
                            <p>{$text.USP_CANCELLATION_TIME}</p>
                            {if $text.USP_CANCELLATION_TIME_2}
                                <p class="usp_subtext">{$text.USP_CANCELLATION_TIME_2}</p>
                            {/if}
                        </li>
                    {/if}
                </ul>
            </div>
        </div>