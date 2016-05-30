<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>
<div>
    <table>
        <tr>
            <td>Move to:
            </td>
            <td>
                <%: Html.DropDownList("product_type_id")%>
            </td>
        </tr>
    </table>
    <button id="btnMoveSave">Save</button>
</div>
<script type="text/javascript">
    $(document).ready(function () {
        $("#btnMoveSave").button().click(function (e) {
            e.preventDefault();
            var selectedType = $("#product_type_id").val();
            var selectedList = GetCheckedList();
            var postData = { selectedType: selectedType, lstProduct: selectedList }
            $.ajax({
                type: "POST",
                url: "<%:Url.Action("MoveProductAction")%>",
                data: postData,
                datatype: "json",
                traditional: true,
                success: function (data) {
                    alert(data.mess);
                    location.reload(true);
                }
            });
        });
    });

</script>
