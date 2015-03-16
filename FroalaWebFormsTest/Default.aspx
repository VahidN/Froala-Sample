<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master"
    ValidateRequest="false"
    EnableEventValidation="false"
    AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="FroalaWebFormsTest.Default" %>

<%--اعتبارسنجي ورودي غيرفعال شده چون بايد تگ ارسال شود--%>
<%--همچنين در وب كانفيگ هم تنظيم ديگري نياز دارد--%>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%--حالت كلاينت آي دي بهتر است تنظيم شود در اينجا--%>
    <asp:TextBox ID="txtEditor" ClientIDMode="Static"
        runat="server" Height="199px" TextMode="MultiLine" Width="447px"></asp:TextBox>
    <br />
    <asp:Button ID="btnSave" runat="server" OnClick="btnSave_Click" Text="ارسال" />

    <style type="text/css">
        /*تنظيم فونت پيش فرض اديتور*/
        .froala-element {
            font-family: tahoma;
            font-size: 9pt;
        }
    </style>

    <script type="text/javascript">
        $(function () {
            $('#txtEditor').editable({
                buttons: ["bold", "italic", "underline", "strikeThrough", "fontFamily",
                    "fontSize", "color", "formatBlock", "align", "insertOrderedList",
                    "insertUnorderedList", "outdent", "indent", "selectAll", "createLink",
                    "insertImage", "insertVideo", "undo", "redo", "html", "save", "inserthorizontalrule",
                    'uploadFile',
                    "insertHTML" //custom button
                ],
                inlineMode: false,
                inverseSkin: true,
                preloaderSrc: 'Content/img/preloader.gif',
                allowedImageTypes: ["jpeg", "jpg", "png"],
                height: 300,
                language: "fa",
                direction: "rtl",
                fontList: ["Tahoma, Geneva", "Arial, Helvetica", "Impact, Charcoal"],
                autosave: true,
                autosaveInterval: 2500,
                saveURL: 'FroalaHandler.ashx',
                saveParams: { postId: "123" },
                spellcheck: true,
                plainPaste: true,
                imageButtons: ["removeImage", "replaceImage", "linkImage"],
                borderColor: '#00008b',
                imageUploadURL: 'FroalaHandler.ashx',
                imageParams: { postId: "123" },
                fileUploadURL: 'FroalaHandler.ashx',
                fileUploadParams: { postId: "123" },
                enableScript: false,

                customButtons: {
                    insertHTML: {
                        title: 'Insert Code',
                        icon: {
                            type: 'font',
                            value: 'fa fa-dollar' // Font Awesome icon class fa fa-*
                        },
                        callback: function () {
                            var thisEditor = this;
                            thisEditor.saveSelection();

                            var codeModal = $("<div>").addClass("froala-modal").appendTo("body");
                            var wrapper = $("<div>").addClass("f-modal-wrapper").appendTo(codeModal);
                            $("<h4>").append('<span data-text="true">Insert Code</span>')
                                .append($('<i class="fa fa-times" title="Cancel">')
                                .click(function () {
                                    codeModal.remove();
                                }))
                                .appendTo(wrapper);

                            var dialog = "<textarea id='code_area' style='height: 211px; width: 538px;' /><br/><label>Language:</label><select id='code_lang'><option>CSharp</option><option>VB</option><option>JScript</option><option>Sql</option><option>XML</option><option>CSS</option><option>Java</option><option>Delphi</option></select> <input type='button' name='insert' id='insert_btn' value='Insert' /><br/>";
                            $(dialog).appendTo(wrapper);

                            $("#code_area").text(thisEditor.text());

                            if (!thisEditor.selectionInEditor()) {
                                thisEditor.$element.focus();
                            }

                            $('#insert_btn').click(function () {
                                var lang = $("#code_lang").val();
                                var code = $("#code_area").val();
                                code = code.replace(/\s+$/, ""); // rtrim
                                code = $('<span/>').text(code).html(); // encode

                                var htmlCode = "<pre class='brush: " + lang.toLowerCase() + "' language='" + lang + "' name='code'>" + code + "</pre></div>"; // syntaxhighlighter با این کد هماهنگ است
                                //var htmlCode = "<pre language='" + lang + "' name='code'>" + code + "</pre></div>";
                                var codeBlock = "<div align='left' dir='ltr'>" + htmlCode + "</div><br/>";

                                thisEditor.restoreSelection();
                                thisEditor.insertHTML(codeBlock);
                                thisEditor.saveUndoStep();

                                codeModal.remove();
                            });
                        }
                    }
                }

            });
        });
    </script>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtEditor" ErrorMessage="RequiredFieldValidator"></asp:RequiredFieldValidator>
</asp:Content>

