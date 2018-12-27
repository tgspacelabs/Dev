﻿
CREATE PROCEDURE [dbo].[WriteBinInfo]
  (
  @UserID              DUSER_ID,
  @PatientID           DPATIENT_ID,
  @TemplateSetIndex    INT,
  @TemplateIndex       INT,
  @BinNumber           INT,
  @Source              INT,
  @BeatCount           INT,
  @FirstBeatNumber     INT,
  @NonIgnoredCount     INT,
  @FirstNonIgnoredBeat INT,
  @ISOOffset           INT,
  @STOffset            INT,
  @IPoint              INT,
  @JPoint              INT,
  @STClass             INT,
  @SinglesBin          INT,
  @EditBin             INT,
  @SubclassNumber      INT
  )
AS
  BEGIN
    INSERT INTO dbo.int_bin_info
                (user_id,
                 patient_id,
                 template_set_index,
                 template_index,
                 bin_number,
                 source,
                 beat_count,
                 first_beat_number,
                 non_ignored_count,
                 first_non_ignored_beat,
                 iso_offset,
                 st_offset,
                 i_point,
                 j_point,
                 st_class,
                 singles_bin,
                 edit_bin,
                 subclass_number,
                 bin_image)
    VALUES      (@UserID,
                 @PatientID,
                 @TemplateSetIndex,
                 @TemplateIndex,
                 @BinNumber,
                 @Source,
                 @BeatCount,
                 @FirstBeatNumber,
                 @NonIgnoredCount,
                 @FirstNonIgnoredBeat,
                 @ISOOffset,
                 @STOffset,
                 @IPoint,
                 @JPoint,
                 @STClass,
                 @SinglesBin,
                 @EditBin,
                 @SubclassNumber,
                 NULL)
  END


