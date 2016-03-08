﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;

namespace Test
{
    public class DAL
    {
        public string ConnString; // The value of the Connect String, used in all database connections
        List<SqlParameter> _parameters; // The (potential) list of parameters used when executing a stored proc

        /// <summary>
        /// This is a class Contstructor, we discuss this concept in Module 9 Lesson 1 & 2
        /// Example usage from other projects:
        /// DAL d = new DAL("Data Source=localhost;Initial Catalog=dbSchool;Integrated Security=SSPI");
        /// </summary>
        /// <param name="connString">A string parameter to indicate the database to connect to.</param>
        public DAL()
        {
            ConnString = "Data Source=SQLEXPRESS;Initial Catalog=test;Integrated Security=SSPI"; // Set the internal variable ConnString to the value of the user chosen value connString
            _parameters = new List<SqlParameter>(); // initialize our list of parameters to 0
        }

        /// <summary>
        /// A method used to add an SqlParameter to a List of SqlParameters, which will eventually be use when 
        /// executing a stored procedure with ExecuteProcedure() below.
        /// Example usage from an external project:
        /// d.AddParam("@FirstName",txtFirstName.Text);
        /// d.AddParam("@LastName",txtLastName.Text);
        /// d.AddParam("@City",txtCity.Text);
        /// </summary>
        /// <param name="paramName">String variable representing the name of the parameter in an SQL Stored Procedure</param>
        /// <param name="paramValue">The value of the above parameter</param>
        public void AddParam(string paramName, object paramValue)
        {
            _parameters.Add(new SqlParameter(paramName, paramValue.ToString())); // create a new SqlParameter object with the use chosen values, add it to the internal list of parameters
        }

        /// <summary>
        /// A method which uses the ConnString and _parameters properties above to execute a user specified stored procedure.
        /// The result of the execution is returned back in the form of a populated DataSet (assuming the stored procedure returns values).
        /// Example usage from an external project (note, you must have used the constructor() and passed a ConnString before using the below code
        /// Also, if you need parameters, the AddParam() would have had to been run before this code as well):
        /// DataSet ds = d.Execute("spGetClient");
        /// </summary>
        /// <param name="ProcName">A string value representing a stored procedure to execute</param>
        /// <returns>A resulting DataSet from executing the stored proc specified in ProcName. Note: An INSERT/DELETE/UPDATE procedure may return an empty DataSet.</returns>
        public DataSet ExecuteProcedure(string ProcName)
        {
            DataSet dsResult = new DataSet();

            SqlConnection conn = new SqlConnection(ConnString);
            SqlDataAdapter da = new SqlDataAdapter(ProcName, conn);
            da.SelectCommand.CommandType = CommandType.StoredProcedure;

            // Runs through each of the parameters one by one based on the list "_parameters"
            // This list must have been populated before running ExecuteProcedure()
            foreach (SqlParameter parameter in _parameters)
            {
                da.SelectCommand.Parameters.Add(parameter);
            }

            conn.Open();
            da.Fill(dsResult);
            conn.Close();

            return dsResult;
        }

        public string ExecuteScalar(string ProcName)
        {
            SqlConnection conn = new SqlConnection(ConnString);
            SqlCommand cmd = new SqlCommand(ProcName, conn);
            cmd.CommandType = CommandType.StoredProcedure;

            // Runs through each of the parameters one by one based on the list "_parameters"
            // This list must have been populated before running ExecuteProcedure()
            foreach (SqlParameter parameter in _parameters)
            {
                cmd.Parameters.Add(parameter);
            }

            conn.Open();
            string result = cmd.ExecuteScalar().ToString();
            conn.Close();

            return result;
        }

        public void ExecuteNonQuery(string ProcName)
        {
            SqlConnection conn = new SqlConnection(ConnString);
            SqlCommand cmd = new SqlCommand(ProcName, conn);
            cmd.CommandType = CommandType.StoredProcedure;

            // Runs through each of the parameters one by one based on the list "_parameters"
            // This list must have been populated before running ExecuteProcedure()
            foreach (SqlParameter parameter in _parameters)
            {
                cmd.Parameters.Add(parameter);
            }

            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
        }

        /// <summary>
        /// If you are using the same DAL object to run more than one procedure in a block of code, you may want to
        /// reset the parameters first! Use this code to wipe out any existing parameters from the DAL.
        /// 
        /// Example usage:
        /// DAL d = new DAL("Data Source=localhost;Initial Catalog=dbImages;Integrated Security=SSPI");
        /// d.AddParam("ClientId",clientId);
        /// DataSet ds = d.ExecuteProcedure("spGetClients");
        /// d.ClearParams();
        /// d.AddParam("SubscriptionId",subId);
        /// d.ExecuteProcedure("spRemoveSubScription");
        /// </summary>
        public void ClearParams()
        {
            _parameters = new List<SqlParameter>();
        }
    }
}