<#-- @ftlvariable name="currentUser" type="com.pjwards.aide.domain.CurrentUser" -->

<!-- Navigation -->
<nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
    <div class="navbar-default sidebar" role="navigation">
        <div class="sidebar-nav navbar-collapse">
            <ul class="nav" id="side-menu">
                <#--<li class="sidebar-search">-->
                    <#--<div class="input-group custom-search-form">-->
                        <#--<input type="text" class="form-control" placeholder="Search...">-->
                                    <#--<span class="input-group-btn">-->
                                    <#--<button class="btn btn-default" type="button">-->
                                        <#--<i class="fa fa-search"></i>-->
                                    <#--</button>-->
                                <#--</span>-->
                    <#--</div>-->
                    <#--<!-- /input-group &ndash;&gt;-->
                <#--</li>-->
                <li>
                    <a href="/user/${currentUser.id?c}"><i class="fa fa-user fa-fw"></i>Profile</a>
                </li>
                <li>
                    <a href="/settings/update"><i class="fa fa-gear fa-fw"></i>Profile Update</a>
                </li>
                <li>
                    <a href="/settings/password"><i class="fa fa-check fa-fw"></i>Password Change</a>
                </li>
                <li>
                    <a href="/settings/delete"><i class="fa fa-times fa-fw"></i>Delete Account</a>
                </li>
                <#if currentUser.role == "ADMIN">
                <li>
                    <a href="/settings/users"><i class="fa fa-users fa-fw"></i>User list</a>
                </li>
                </#if>
            </ul>
        </div>
        <!-- /.sidebar-collapse -->
    </div>
    <!-- /.navbar-static-side -->
</nav>