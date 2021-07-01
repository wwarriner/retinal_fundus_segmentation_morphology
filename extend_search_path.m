function extend_search_path()

addpath( genpath( pwd ) );

removed_paths = { ...
    '.git', ...
    '.vscode' ...
    };    
cellfun( @(x) rmpath( genpath( fullfile( pwd, x ) ) ), removed_paths );

end