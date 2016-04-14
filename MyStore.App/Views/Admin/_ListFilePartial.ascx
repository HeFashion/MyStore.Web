<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<System.Collections.Generic.IList<string>>" %>

<div class="modal-content">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4>Select Image</h4>
    </div>
    <div class="modal-body">
        <div class="table-wrapper">
            <div class="table-scroll">
                <table>
                    <thead>
                        <tr>
                            <th class="select">Select</th>
                            <th>Image
                            </th>
                            <th>Name
                            </th>
                        </tr>
                    </thead>
                    <%foreach (string strFileName in Model)
                      { %>
                    <tr>
                        <td class="select">
                            <input type="radio" name="rdbSelected" value="<%:Url.Content(strFileName) %>" />
                        </td>
                        <td>
                            <img src="<%:Url.Content(strFileName) %>" alt="<%:strFileName %>" />
                        </td>
                        <td>
                            <%:System.IO.Path.GetFileNameWithoutExtension(strFileName) %>
                        </td>
                    </tr>
                    <%} %>
                </table>

            </div>
        </div>
    </div>
    <div class="modal-footer">
        <a class="btn btn-default" data-dismiss="modal">OK</a>
    </div>
</div>
