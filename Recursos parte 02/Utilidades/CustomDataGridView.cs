

namespace SVPresentation.Utilidades
{
    public static class CustomDataGridView
    {

        public static void ImplementarConfiguracion(this DataGridView datagrid, string textoEnBoton ="")
        {
            datagrid.AllowUserToAddRows = false;
            datagrid.AllowUserToDeleteRows = false;
            datagrid.AllowUserToResizeColumns = true;
            datagrid.AllowUserToResizeRows = false;
            datagrid.AllowUserToOrderColumns = false;
            datagrid.ColumnHeadersBorderStyle = DataGridViewHeaderBorderStyle.Single;
            datagrid.SelectionMode = DataGridViewSelectionMode.FullRowSelect;
            datagrid.MultiSelect = false;
            datagrid.RowHeadersVisible = false;
            datagrid.ReadOnly = true;
            datagrid.BackgroundColor = Color.White;
            datagrid.ColumnHeadersDefaultCellStyle = new DataGridViewCellStyle
            {
                BackColor = Color.FromArgb(58, 49, 69),
                SelectionBackColor = Color.FromArgb(58, 49, 69),
                ForeColor = Color.FromArgb(255, 255, 255)
            };
            datagrid.DefaultCellStyle = new DataGridViewCellStyle
            {
                SelectionBackColor = Color.FromArgb(191, 176, 209),
                SelectionForeColor = Color.FromArgb(0, 0, 0),
            };
            datagrid.ColumnHeadersHeight = 30;
            datagrid.EnableHeadersVisualStyles = false;
            datagrid.ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.EnableResizing;


            if (textoEnBoton != "") {
                var btnEditarColumn = new DataGridViewButtonColumn();
                btnEditarColumn.Text = textoEnBoton;
                btnEditarColumn.Name = "ColumnaAccion";
                btnEditarColumn.HeaderText = "";
                btnEditarColumn.UseColumnTextForButtonValue = true;
                btnEditarColumn.Width = 50;
                btnEditarColumn.AutoSizeMode = DataGridViewAutoSizeColumnMode.DisplayedCells;


                datagrid.Columns.Add(btnEditarColumn);

            }


        }

    }
}
