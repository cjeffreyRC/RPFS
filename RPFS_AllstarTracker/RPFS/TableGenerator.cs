﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.UI.HtmlControls;
using System.Data;
using DataAccessLayer;

namespace RPFS
{
    public class TableGenerator
    {
        static public HtmlGenericControl CreateTable(string storedProc)
        {
            DAL d = new DAL();
            DataSet ds = d.ExecuteProcedure(storedProc);

            return CreateDivTable(ds);

        }
        static public HtmlGenericControl CreateTable(string storedProc,string param,int paramValue)
        {
            DAL d = new DAL();
            d.AddParam(param, paramValue);
            DataSet ds = d.ExecuteProcedure(storedProc);

            return CreateDivTable(ds);

        }
        static private HtmlGenericControl CreateDivTable(DataSet ds)
        {
            HtmlGenericControl tb = new HtmlGenericControl("div");
            tb.Attributes.Add("class", "container-fluid");
            tb.Attributes.Add("runat", "server");
            InitDivTable(ds.Tables[0], tb);

            return tb;
        }


        static public HtmlGenericControl InitDivTable(DataTable dt, HtmlGenericControl tb)
        {
            int[] rowIdArray = new int[dt.Rows.Count];
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                rowIdArray[i] = int.Parse(dt.Rows[i][0].ToString());
            }
            dt.Columns.RemoveAt(0);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                tb.Controls.Add(CreateDivRow(dt.Rows[i], rowIdArray[i]));
            }
            return tb;
        }

        static private HtmlGenericControl CreateDivRow(DataRow dr, int rowId)
        {
            HtmlGenericControl row = new HtmlGenericControl("div");
            row.Attributes.Add("class", "row");
            row.Attributes.Add("runat", "server");
            row.Attributes.Add("id", rowId.ToString());
            int colCount = dr.Table.Columns.Count;

            for (int i = 0; i < colCount; i++)
            {
                row.Controls.Add(CreateDivCol(dr[i]));
            }
            return row;
        }

        static private HtmlGenericControl CreateDivCol(object colValue)
        {
            HtmlGenericControl col = new HtmlGenericControl("div");
            col.Attributes.Add("class", "col-xs-3");
            col.Attributes.Add("ondrop", "return true");
            col.Attributes.Add("ondragover", "return true");
            col.Attributes.Add("runat", "server");
            col.InnerText = colValue.ToString();
            return col;
        }
        //Column size is currently hard coded to 3 of 12 - max of 4 columns
    }
}
