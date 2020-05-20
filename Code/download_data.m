function filename = download_data(file_url)
    % This function takes in the URL, finds the filename and downloads the 
    % source file into the directory. 
    
    filename = extractBetween(file_url, max(strfind(file_url,'/'))+1, length(file_url{1}));
    if(~isfile(filename))
        % If the file is not in the folder then it is downloaded
        fprintf("Downloading %s.\n\n",filename)
        websave(filename, file_url);
        if(contains(filename,".zip"))
           % If the file is a .zip file then unzip
           fprintf("Unzipping %s.\n\n",filename)
           filename = unzip(filename);
        end
    else
        % If the file already exists
        fprintf("%s already exists in folder.\n\n",filename)
        if(contains(filename, ".zip"))
            % Removes .zip from the end of the filename if the file has already been imported
            filename = extractBetween(filename, 1, length(filename{1})-4);
        end
        if(contains(filename, "_CSV"))
            % Changes _CSV to .CSV so that the data import works in either case
            filename = extractBetween(filename, 1, length(filename{1})-4) + ".CSV";
            
            % Converts cell value to string
            if(iscell(filename))
                filename = filename{1};
            end
        end
    end
end