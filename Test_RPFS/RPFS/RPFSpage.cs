using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.UI.HtmlControls;

namespace RPFS
{
    class RPFSpage
    {
        private HtmlGenericControl CreateDivTable(DataSet ds)
        {
            HtmlGenericControl tb = new HtmlGenericControl("div");
            tb.Attributes.Add("class", "container-fluid");
            DataTable dt = ds.Tables[0];
            int colCount = dt.Columns.Count;
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                tb.Controls.Add(CreateDivRow(dt.Rows[i]));
            }
            return tb;
        }

        private HtmlGenericControl CreateDivRow(DataRow dr)
        {
            HtmlGenericControl row = new HtmlGenericControl("div");
            row.Attributes.Add("class", "row");
            int colCount = dr.Table.Columns.Count;

            for (int i = 0; i < colCount; i++)
            {
                row.Controls.Add(CreateDivCol(dr[i]));
            }
            return row;
        }

        private HtmlGenericControl CreateDivCol(object colValue)
        {
            HtmlGenericControl col = new HtmlGenericControl("div");
            col.Attributes.Add("class", "col-xs-2");
            col.InnerText = colValue.ToString();
            return col;
        }
    }
}
