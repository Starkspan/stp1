import express from 'express';
import multer from 'multer';
import { exec } from 'child_process';
import path from 'path';
import { fileURLToPath } from 'url';
import fs from 'fs';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const app = express();
const port = process.env.PORT || 3000;

const upload = multer({ dest: 'uploads/' });

app.use('/files', express.static(path.join(__dirname, 'converted')));

app.post('/upload-stp', upload.single('file'), (req, res) => {
    const inputPath = path.join(__dirname, req.file.path);
    const outputFilename = req.file.originalname.replace(/\.(stp|step)$/i, '.glb');
    const outputPath = path.join(__dirname, 'converted', outputFilename);

    const command = `FreeCADCmd converters/convertStepToGlb.py "${inputPath}" "${outputPath}"`;

    exec(command, (error, stdout, stderr) => {
        if (error) {
            console.error(`Fehler bei Konvertierung: ${error.message}`);
            return res.status(500).send('Konvertierung fehlgeschlagen');
        }

        return res.json({ glbUrl: `/files/${outputFilename}` });
    });
});

app.listen(port, () => {
    console.log(`STP-Konvertierungsserver läuft auf Port ${port}`);
});