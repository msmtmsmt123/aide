<#import "/spring.ftl" as spring/>
<#-- @ftlvariable name="conference" type="com.pjwards.aide.domain.Conference" -->
<#-- @ftlvariable name="currentUser" type="com.pjwards.aide.domain.CurrentUser" -->
<#-- @ftlvariable name="form" type="com.pjwards.aide.domain.forms.ProgramForm" -->
<#-- @ftlvariable name="rc" type="javax.servlet.http.HttpServletRequest" -->
<#-- @ftlvariable name="_csrf" type="org.springframework.security.web.csrf.CsrfToken" -->

<@layout.extends name="layouts/default.ftl">
    <@layout.put block="head">
    <title>${myApp.name} :: Programs :: Add</title>

    <!-- Custom CSS -->
    <link href="/lib/sb-admin/dist/css/sb-admin-2.css" rel="stylesheet">

    <!-- MetisMenu CSS -->
    <link href="/bower_components/metisMenu/dist/metisMenu.min.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="http://fonts.googleapis.com/css?family=Lora:400,700,400italic,700italic" rel="stylesheet"
          type="text/css">
    <link href="http://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
    </@layout.put>

    <@layout.put block="header" type="prepend">
        <@layout.extends name="layouts/header/admin.ftl">
        </@layout.extends>
    </@layout.put>


    <@layout.put block="contents">
        <@spring.bind "form" />

    <section>
        <div id="wrapper">
            <div id="page-wrapper">
                <#if spring.status.error>
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="alert alert-dismissable alert-danger text-center">
                                <button type="button" class="close" data-dismiss="alert">×</button>
                                <#list spring.status.errorMessages as error>
                                    <p>${error}</p>

                                    <#if error?contains("Title")><#global errorTitle=true></#if>
                                    <#if error?contains("Description")><#global errorDescription=true></#if>
                                    <#if error?contains("Begin")><#global errorBegin=true></#if>
                                    <#if error?contains("End")><#global errorEnd=true></#if>
                                    <#if error?contains("Slide")><#global errorSlide=true></#if>
                                    <#if error?contains("Video")><#global errorVideo=true></#if>
                                    <#if error?contains("Day")><#global errorDay=true></#if>
                                    <#if error?contains("Room")><#global errorRoom=true></#if>
                                    <#if error?contains("Speaker")><#global errorSpeaker=true></#if>
                                </#list>
                            </div>
                        </div>
                        <!-- /.col-lg-12 -->
                    </div>
                    <!-- /.row -->
                </#if>
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">
                            Program Add
                        </h1>
                    </div>
                    <!-- /.col-lg-12 -->
                </div>
                <!-- /.row -->
                <div class="row">
                    <div class="col-lg-12" style="text-align: center;">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <form role="form" action="" method="post" enctype="multipart/form-data">
                                    <div class="panel-group" id="accordion">
                                        <div class="panel panel-success">
                                            <div class="panel-heading">
                                                <h4 class="panel-title">
                                                    <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">Basic Information</a>
                                                </h4>
                                            </div>
                                            <div id="collapseOne" class="panel-collapse collapse in">
                                                <div class="panel-body">
                                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

                                                    <div class="form-group <#if errorTitle??>has-error</#if>">
                                                        <input class="form-control" name="title" placeholder="Title *" value="${form.title}">
                                                    </div>

                                                    <div class="form-group <#if errorDescription??>has-error</#if>" style="text-align: left">
                                                        <textarea class="form-control" id="summernote" name="description" placeholder="Description *"> <#if form.description?? && form.description != "">${form.description}<#else>Description *</#if></textarea>
                                                    </div>

                                                    <div class="form-group <#if errorBegin??>has-error</#if>">
                                                        <input class="form-control" name="begin" placeholder="Begin * ex) hh:mm" value="${form.begin}">
                                                    </div>

                                                    <div class="form-group <#if errorEnd??>has-error</#if>">
                                                        <input class="form-control" name="end" placeholder="End * ex) hh:mm" value="${form.end}">
                                                    </div>

                                                    <div class="panel panel-default">
                                                        <div class="panel-heading">
                                                            <h4 class="panel-title">
                                                                Program Type
                                                            </h4>
                                                        </div>
                                                        <div class="panel-body">
                                                            <div class="form-group">
                                                                <#list form.programTypeList as list>
                                                                    <label class="radio-inline">
                                                                        <input type="radio" name="programType" id="status_${list_index}" value="${list}" <#if form.programType == list >checked</#if>>
                                                                    ${list}
                                                                    </label>
                                                                </#list>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="form-group <#if errorDay??>has-error</#if>">
                                                        <select name="programDateId" class="form-control">
                                                            <#list conference.programDates as date>
                                                                <option value="${date.id}" <#if form.programDateId?? && form.programDateId == date.id>selected</#if>>${date.name}</option>
                                                            </#list>
                                                        </select>
                                                    </div>

                                                    <div class="form-group <#if errorRoom??>has-error</#if>">
                                                        <select name="roomId" class="form-control">
                                                            <#list conference.rooms as room>
                                                                <option value="${room.id}" <#if form.roomId?? && form.roomId == room.id>selected</#if>>${room.name}</option>
                                                            </#list>
                                                        </select>
                                                    </div>

                                                    <div class="form-group <#if errorSpeaker??>has-error</#if>">
                                                        <select name="speakers" multiple class="form-control">
                                                            <#list conference.participants as user>
                                                                <option value="${user.id}" <#if form.speakers?has_content && form.speakers?seq_contains(user.id)>selected</#if>>${user.name}</option>
                                                            </#list>
                                                        </select>
                                                    </div>
                                                </div>
                                                <!-- /.panel-body -->
                                            </div>
                                            <!-- /.collapse -->
                                        </div>
                                        <!-- /.panel -->

                                        <div class="panel panel-warning">
                                            <div class="panel-heading">
                                                <h4 class="panel-title">
                                                    <a data-toggle="collapse" data-parent="#accordion" href="#collapseTwo">Slide & Video Information</a>
                                                </h4>
                                            </div>
                                            <div id="collapseTwo" class="panel-collapse collapse">
                                                <div class="panel-body">
                                                    <div class="form-group <#if errorSlide??>has-error</#if>">
                                                        <input class="form-control" name="slideUrl" placeholder="Slide Url" value="${form.slideUrl}">
                                                    </div>

                                                    <div class="form-group">
                                                        <textarea class="form-control" name="slideEmbed" placeholder="Slide Embed">${form.slideEmbed}</textarea>
                                                    </div>

                                                    <div class="form-group <#if errorVideoUrl??>has-error</#if>">
                                                        <input class="form-control" name="videoUrl" placeholder="Video Url" value="${form.videoUrl}">
                                                    </div>

                                                    <div class="form-group">
                                                        <textarea class="form-control" name="videoEmbed" placeholder="Video Embed">${form.videoEmbed}</textarea>
                                                    </div>
                                                </div>
                                                <!-- /.panel-body -->
                                            </div>
                                            <!-- /.collapse -->
                                        </div>
                                        <!-- /.panel -->
                                    </div>
                                    <!-- /.panel group -->
                                    <a class="btn btn-danger" href="/conferences/${conference.id}/admin/programs">Cancel</a>
                                    <button type="submit" class="btn btn-default">Add</button>
                                </form>
                            </div>
                            <!-- /.panel-body -->
                        </div>
                        <!-- /.panel -->
                    </div>
                    <!-- /.col-lg-12 -->
                </div>
                <!-- /.row -->

            </div>
            <!-- /#page-wrapper -->

        </div>
        <!-- /#wrapper -->

    </section>

    </@layout.put>

    <@layout.put block="footer" type="replace">
        <@layout.extends name="layouts/footer.ftl">
        </@layout.extends>
    </@layout.put>

    <@layout.put block="script">
    <!-- Metis Menu Plugin JavaScript -->
    <script src="/bower_components/metisMenu/dist/metisMenu.min.js"></script>

    <!-- Custom Theme JavaScript -->
    <script src="/lib/sb-admin/dist/js/sb-admin-2.js"></script>

    <script src="/js/summernote.js"></script>
    </@layout.put>
</@layout.extends>