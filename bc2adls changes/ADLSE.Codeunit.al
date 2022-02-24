// Copyright (c) Microsoft Corporation.
// Licensed under the MIT License. See LICENSE in the project root for license information.
codeunit 82567 ADLSE
{
    /// <summary>
    /// This is the main facade of Azure Data Lake Storage Export (ADLSE).
    /// </summary>

    Access = Public;

    var
        ADSLECommunication: Codeunit "ADLSE Communication";
        ADLSEUtil: Codeunit "ADLSE Util";

    procedure WriteLinesToCsvStream(var TempBlob: Codeunit "Temp Blob"; var Payload: TextBuilder; RecRef: RecordRef; var SchemaJson: JsonArray)
    begin
        ADLSEUtil.WriteLinesToCsvStream(TempBlob, Payload, RecRef, SchemaJson);
    end;

    procedure WriteHeadersToCsvStream(var TempBlob: Codeunit "Temp Blob"; var Payload: TextBuilder; RecRef: RecordRef; var SchemaJson: JsonArray)
    begin
        ADLSEUtil.WriteHeadersToCsvStream(TempBlob, Payload, RecRef, SchemaJson);
    end;

    procedure AppendPayload(Payload: TextBuilder)
    begin
        ADSLECommunication.AppendPayload(Payload);
    end;

    procedure Init(TableIDValue: Integer; FieldIdListValue: List of [Integer]; LastFlushedTimeStampValue: BigInteger; EmitTelemetryValue: Boolean)
    begin
        ADSLECommunication.Init(TableIDValue, FieldIdListValue, LastFlushedTimeStampValue, EmitTelemetryValue);
    end;

    procedure CreateDataBlob()
    begin
        ADSLECommunication.CreateDataBlob();
    end;

    procedure FlushPayload();
    begin
        ADSLECommunication.FlushPayload();
    end;

    procedure CheckEntity(var EntityJsonNeedsUpdate: Boolean; var ManifestJsonsNeedsUpdate: Boolean)
    begin
        ADSLECommunication.CheckEntity(EntityJsonNeedsUpdate, ManifestJsonsNeedsUpdate);
    end;

    procedure TryUpdateCdmJsons(var EntityJsonNeedsUpdate: Boolean; var ManifestJsonsNeedsUpdate: Boolean)
    begin
        ADSLECommunication.TryUpdateCdmJsons(EntityJsonNeedsUpdate, ManifestJsonsNeedsUpdate);
    end;

    /// <summary>
    /// This function will clear all variables in ADSLE Communication. 
    /// </summary>
    procedure Flush();
    begin
        ADSLECommunication.Flush();
    end;

    /// <summary>
    /// This is the event which represents a successful export of a batch of 
    /// records for a single table to the data lake.
    /// </summary>
    /// <param name="TableID">
    /// The table number whose data was exported.
    /// </param>
    /// <param name="LastTimeStampExported">
    /// The value for the TimeStamp field for the last record that was synced.
    /// </param>
    [IntegrationEvent(false, false)]
    internal procedure OnTableExported(TableID: Integer; LastTimeStampExported: BigInteger)
    begin
    end;
}